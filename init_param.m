function param = init_param(func_name, encoding)

    func_name = lower(func_name);
    encoding = lower(encoding);

    param.pop_size = 100;
    param.encoding = encoding;
    
    switch func_name
        case 'sch'
            param.dim = 1;
            param.upper_bound = ones(1, param.dim) * 1000;
            param.lower_bound = -ones(1, param.dim) * 1000;
            param.chrom_length = 30;
        case 'srn'
            param.dim = 2;
            param.upper_bound = ones(1, param.dim) * 20;
            param.lower_bound = -ones(1, param.dim) * 20;
            param.chrom_length = 30;
        
        case 'zdt1'
            param.dim = 30;
            param.upper_bound = ones(1, param.dim);
            param.lower_bound = zeros(1, param.dim);
            param.chrom_length = 30;
            
        case 'zdt2'
            param.dim = 30;
            param.upper_bound = ones(1, param.dim);
            param.lower_bound = zeros(1, param.dim);
            param.chrom_length = 30;
            
        case 'zdt3'
            param.dim = 30;
            param.upper_bound = ones(1, param.dim);
            param.lower_bound = zeros(1, param.dim);
            param.chrom_length = 30;
            
        case 'zdt4'
            param.dim = 10;
            param.upper_bound = ones(1, param.dim) * 5;
            param.lower_bound = ones(1, param.dim) * -5;
            param.upper_bound(1) = 1;
            param.lower_bound(1) = 0;
            param.chrom_length = 30;
            
        case 'zdt6'
            param.dim = 10;
            param.upper_bound = ones(1, param.dim);
            param.lower_bound = zeros(1, param.dim);
            param.chrom_length = 30;
            
        case 'fon'
            param.dim = 3;
            param.upper_bound = ones(1, param.dim) * 4;
            param.lower_bound = ones(1, param.dim) * -4;
            param.chrom_length = 30;
            
        case 'kur'
            param.dim = 3;
            param.upper_bound = ones(1, param.dim) * 5;
            param.lower_bound = ones(1, param.dim) * -5;
            param.chrom_length = 30;
    end

    if strcmpi(encoding, 'real')
        param.pc = 0.9;
        param.pm = 1 / param.dim;
        param.eta_c = 20;
        param.eta_m = 20;
    end
    if strcmpi(encoding, 'binary') 
        param.pc = 0.9;
        param.pm = 1 /  param.chrom_length; 
    end
end