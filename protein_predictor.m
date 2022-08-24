function [] = protein_predictor(seq,prot_name)
    % computes and shows graphs for the epitope prediction of the protein
    %INPUT:
    % seq = amino acid sequence for the protein
    % prot_name = the name of the protein

    window_size = 6; % as shown in https://doi.org/10.1002/9780470122921.ch2
    
    %get graph for the sequenece for each parameter
    b = protein_analyzer(seq,'b',window_size); % beta-turn
    a = protein_analyzer(seq,'a',window_size); % antigenicity
    s = protein_analyzer(seq,'s',window_size); % surface accessabilty
    h = protein_analyzer(seq,'h',window_size); % hydropathy

    % get the 'true' values from IEDB
    compare = readtable(prot_name+".csv").Score;
    % the length of b/a/s/h = length(sequnce)-window_size+1, therefore we
    % need equal sizes:
    compare = compare(1:length(b));

    % k-fold cross validation - to compute error
    folds = 10; % arbitrary chosen for k-fold
    pick = ceil(folds/2); % arbitrary selection of segment to be used as the test segment
    len = length(b); % sequence length
    for k=1:folds
        start = ceil((len/folds)*(k-1)+1);
        finish = ceil((len/folds)*k);
        window = start:finish; % the part to remove
        b_train = b;
        b_train(window) = []; %delete the test sets
        a_train = b;
        a_train(window) = [];
        s_train = b;
        s_train(window) = [];
        h_train = b;
        h_train(window) = [];
        comp_train = compare;
        comp_train(window)=[];

        % create a model
        X = [b_train,a_train,s_train,h_train];
        model = fitlm(X,comp_train); 
        vals = model.Coefficients.Estimate; % get coefficiants for each parameter to fit the model
        total_pred = vals(1) + b*vals(2) + a*vals(3) + s*vals(4) + h*vals(5); % get the predicted model
        if k==pick
            total = normalize(total_pred); % save this specific model for the graph
        end
        %compute error rates:
        errors = (compare-total_pred).^2; 
        test_set_avg(k) = mean(errors(start:finish));
        train_set_avg(k) = mean(setdiff(errors,window));
    end

    % display error rates:
    disp("Protein: "+prot_name);
    disp("Avg train error:"+mean(train_set_avg));
    disp("Avg test error:"+mean(test_set_avg));
    Figures(b,a,s,h,total,prot_name);

end