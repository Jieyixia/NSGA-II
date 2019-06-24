function de_pop = binary2decimal(pop, param)
% transform binary code to decimal code
%
% pop: binary coded population
% dim: number of decision variables
% chromlength: the length of chromosome 
% 
% de_pop: decimal coded population

    [pop_size, ~] = size(pop);
    dim = param.dim;
    U = param.upper_bound;
    L = param.lower_bound;
    chrom_length = param.chrom_length;
    
    de_pop = zeros(pop_size, dim);
    
    for i = 1 : dim
        temp = 0;
        start = (i - 1) * chrom_length;
        for j = 1 : chrom_length
            temp = temp + pop(:, start + j) * 2^(chrom_length - j);
        end
        de_pop(:, i) = L(i) + (U(i) - L(i)) / (2^chrom_length - 1) * temp;
    end
    
end