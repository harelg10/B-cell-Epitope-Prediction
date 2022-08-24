function [vec] = protein_analyzer(seq,parameter,window_size)
% INPUT:
% seq = sequence of a protein
% parameter = the requested parameter ('b' - beta-turn, 'a' - antigenicity, 's' - surface accessabilty, 'h' - hydropathy)
% window_size = window of x AAs checked as a bulk. default = 6.
% OUTPUT:
% vec = score values of requested sequence of that test

    len = length(seq)-window_size+1; % we dont calculate the last positions because we have less information about them 

    results = zeros(len,1);

    for i=1:(len)
        score = 0;
        for j=1:window_size
            result = get_value(seq(i+j-1),parameter);
            score = score + result;
        end
        val = score/window_size;
        results(i) = val;

    end
    
    results = normalize(results);
    vec =results;

end