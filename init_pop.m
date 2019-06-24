function pop = init_pop(param)
% generate initial population
%
% popsize: the size of the population
% dim: number of decision variables
% [L, U]: range of decision variables
% chromlength: the length of chromosome. If not received, the population should be
% decimal coded, else, binary coded
%
% pop: generated population

    
    if strcmpi(param.encoding, 'binary')
        pop = init_bi_pop(param);
    end
    
    if strcmpi(param.encoding, 'real')
        pop = init_real_pop(param);
    end
        
end

% -------------------------------------------------------------------------
function pop = init_real_pop(param)
% generate initial decimal coded population
    
    pop_size = param.pop_size;
    dim = param.dim;
    U = param.upper_bound;
    L = param.lower_bound;
    
    pop = L + (U - L) .* rand(pop_size, dim);
end

% -------------------------------------------------------------------------
function pop = init_bi_pop(param)
% generate initial binary coded population
    
    pop_size = param.pop_size;
    dim = param.dim;
    chrom_length = param.chrom_length;
  
    pop = round(rand(pop_size, chrom_length * dim));
    
end