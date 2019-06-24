function [phi, obj_value] = fast_non_dominated_sort(pop, param)
% fitness assignment(based on nondominated level)
%
% pop:  population
% param: structure with paramenters
% de_point: the place of decimal point. if de_point == 0, real coded, else,
% binary coded
%
% phi: non-dominant level of each candidate solution
% obj_value: objective function value for each individual
    
    encoding = param.encoding;
    
    if strcmpi(encoding, 'real')
        de_pop = pop;
    else
        de_pop = binary2decimal(pop, param);
    end
       
    [pop_size, ~] = size(pop);
    
    % calculate objective function values
    f = param.f;
    g = param.g;
    fn = numel(f);
    obj_value = zeros(pop_size, fn);
    cv = zeros(pop_size, 1);
    for i = 1 : fn
        obj_value(:, i) = f{i}(de_pop);
        if ~isempty(g)
            temp = g{i}(de_pop);
            cv = cv + temp .* (temp > 0); 
        end
    end
    
    % fast non-dominated sort
    S = cell(pop_size, 1);
    n = zeros(pop_size, 1);
    phi = zeros(pop_size, 1);
    
    % find the individuals in the first non-dominant level

    for i = 1 : pop_size
        S{i} = [];
        for j = 1 : pop_size
            if isdominate(obj_value([i, j], :), cv([i, j]), fn) 
                % individual i dominates individual j
                S{i} = [S{i}; j];
            else
                if isdominate(obj_value([j, i], :), cv([j, i]), fn)
                    % individual j dominates individual i
                    n(i) = n(i) + 1;
                end
            end
        end
        if n(i) == 0
            phi(i) = 1;
        end
    end

    level = 1;

    while ~isempty(find(phi == level, 1))
        index = find(phi == level);
        for i = 1 : numel(index)
            p = index(i);
            for j = 1 : numel(S{p})
                q = S{p}(j);
                n(q) = n(q) - 1;
                if n(q) == 0
                    phi(q) = level + 1;
                end
            end
        end
        level = level + 1;
    end

end

% -------------------------------------------------------------------------
function flag = isdominate(obj_value, cv, fn)
    
    flag = 0; 
    if cv(1) == 0 && cv(2) == 0     
        % if both solutions are feasible
        diff = obj_value(1, :) - obj_value(2, :);    
        if  length(find(diff <= 0)) == fn 
            if length(find(diff < 0)) >= 1
                flag = 1;
                return
            end
        end
    end

    if cv(1) == 0 && cv(2) > 0
        % if one is feasible, the other is not
        flag = 1;
        return
    end

    if cv(1) > 0 && cv(2) > 0
        % if both are infeasible
        if cv(1) < cv(2)
            flag = 1;
            return
        end
    end
end