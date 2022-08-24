function [val] = get_value(aa,parameter)
% INPUT:
% aa = an upper-case letter representing an amino acid ('H','K' etc.)
% parameter = the requested parameter ('b' - beta-turn, 'a' - antigenicity, 's' - surface accessabilty, 'h' - hydropathy)
% OUTPUT:
% val = score value of requested amino acid of that test

    legal_params = 'bash';
    amino_acids = ['G' 'P' 'A' 'V' 'L' 'I' 'M' 'C' 'F' 'Y' 'W' 'H' 'K' 'R' 'Q' 'N' 'E' 'D' 'S' 'T'];

    %sanity check of the input 
    if ( (~contains(legal_params,parameter)) | ~contains(amino_acids,aa) )
        val = 0;
        return;
    end

    %https://pubmed.ncbi.nlm.nih.gov/364941/
    b_turn = [1.56 1.52 0.66 0.5 0.59 0.47 0.60 1.19 0.60 1.14 0.96 0.95 1.01 0.95 0.98 1.56 0.74 1.46 1.43 0.96];
    
    %https://pubmed.ncbi.nlm.nih.gov/1702393/
    antigenicity = [0.874 1.064 1.064 1.383 1.250 1.152 0.826 1.412 1.091 1.161 0.893 1.105 0.930 0.873 1.015 0.776 0.851 0.866 1.012 0.909];
    
    %https://pubmed.ncbi.nlm.nih.gov/3216390/
    surface_accessibility = [0.48 0.75 0.49 0.36 0.40 0.34 0.48 0.26 0.42 0.76 0.52 0.66 0.97 0.95 0.84 0.78 0.84 0.81 0.65 0.70];
    
    %https://pubmed.ncbi.nlm.nih.gov/2430611/
    hydropathy = [5.7 2.1 2.1 -3.7 -9.2 -8.0 -4.2 1.4 -9.2 -1.9 -10 2.1 5.7 4.2 6.0 7.0 7.8 10 6.5 5.2];

    val = 0; 
    index = find(amino_acids == aa); % find the index of required aa

    if parameter == 'b'
        val = b_turn(index);
    elseif parameter == 'a'
        val = antigenicity(index);
    elseif parameter == 's'
        val = surface_accessibility(index);
    elseif parameter == 'h'
        val = hydropathy(index);
    end
end

