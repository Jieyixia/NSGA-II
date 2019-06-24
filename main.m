% NSGA-II
% A Fast and Elitist Multiobjective Genetic Algorithm

% clear
% clc
% a constraint MOP algorithm
% pareto_front = load('srn.txt');
param = init_param('zdt2', 'real');
param = problems('zdt2', param);

% parameters
tmax = 100;
repeat_count = 1;

for i = 1 : repeat_count
    
    P = init_pop(param);  
    t = 0;
    while t < tmax
        
        % step 1: generate Qt from Pt: selection, crossover and mutation
        Q = reproduction(P, param);
        R = [P; Q];
        
        % step 2: elite-preserving operator
        P = elite_preserving(R, param);
        t = t + 1;    
        
        % plot
        if mod(t, 20) == 0
            if strcmpi(param.encoding, 'real')
                de_P = P;
            else
                de_P = binary2decimal(P, param);
            end
            p_f1 = param.f{1}(de_P);
            p_f2 = param.f{2}(de_P);
            p_f = [p_f1, p_f2];
            
            v = hypervolume(p_f);
            fprintf('t = %d, hypervolume = %f\n', t, v)
            
            figure
            plot(p_f(:, 1), p_f(:, 2), '*')
            title(['No.', num2str(t), 'th iteration'])
            
%             % 如果可以画出真实的pareto前沿
%             plot_pareto(pareto_front, [p_f1 p_f2], t);
        end
    end 
    
end



