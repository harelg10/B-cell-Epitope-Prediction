clear
clc
warning('off','all')

%load the data
[sequences,names] = load_data();

% create window
fig = figure;
fig.Name = 'Predictor';
fig.NumberTitle = 'off';
fig.Position = [400,400,200,200];

% create text
annotation('textbox', [0.18, 0.7, 0, 0], 'string', 'Choose a protein','FitBoxToText','on')

% create dropdown
dd = uicontrol(fig,'Style','popupmenu');
dd.String = names;
dd.Position = [50,40,100,40];
dd.Callback = @selection;

    function selection(obj,~,~)
        %Handle event of selection change in the dropdown
        [seqs,names] = load_data();
        parent = findobj(ancestor(obj, 'figure'));
        indx = parent(2).Value;
        seq = convertStringsToChars(seqs(indx));
        name = names{indx};
        protein_predictor(seq,name);
    end

    function [seqs,data_names] = load_data()
        data = readtable("data.xlsx");
        len = length(data.Properties.VariableNames);
        names = string.empty;
        seqs = string.empty;
        data_names = data.Properties.VariableDescriptions;
        for i=1:len
            names(i) = data_names(i);
            seqs(i) = data{1,i};
        end
    end
