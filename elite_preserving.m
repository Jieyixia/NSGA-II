function P = elite_preserving(R, param)
% elite-preserving operator
% R: combined population
% P: the next generation

    [N, d] = size(R);
    pop_size = N / 2;
    P = zeros(pop_size, d);
    f = param.f;
    
    % fast non-dominated sort
    [phi, obj_value] = fast_non_dominated_sort(R, param);
    
    level = 1;
    n = 0;
    while 1
        index = find(phi == level);
        temp = n;
        n = n + numel(index);    
        if n >= pop_size
            if n > pop_size
                break
            end
            P(temp + 1 : n, :) = R(index, :);
            break
        end
        P(temp + 1 : n, :) = R(index, :);
        level = level + 1;
    end
    
    if n == pop_size
        return
    else
        % calculate the crowding distance of the certain non-dominant level
        d = crowded_distance_assignment(phi, level, obj_value, f);
        distance_table = [index d(index)];
        
        % in descending order
        distance_table = sortrows(distance_table, 2, 'descend');
        P(temp + 1 : end, :) = R(distance_table(1 : pop_size - temp), :);
    end
    
end

% -------------------------------------------------------------------------
function d = crowded_distance_assignment(phi, level, obj_value, F)
% phi: non-dominant level of each candidate solution
% level: in which non-dominant level, we should calculate the crowded
% distance
% obj_value: objective function values for each candidate solution
% d: N x 1 array, N is the number of candidate solutions. If i in this level, d(i) ~= 0; else d(i) == 0

    S = find(phi == level);
    I = [S, obj_value(S, :)];
    
    % number of solutions in this non-dominant level
    n = numel(S);
    N = size(obj_value, 1);
    d = zeros(N, 1);
    fn = numel(F);
    for i = 1 : fn
        % rank according to the ith objective function, in ascending order
        I = sortrows(I, i + 1);
        d(I(1)) = inf;
        d(I(n)) = inf;
        f_max = max(obj_value(:, i));
        f_min = min(obj_value(:, i));
        for j = 2 : (n - 1)
            d(I(j)) = d(I(j)) + (I(j + 1, i + 1) - I(j - 1, i + 1)) / (f_max - f_min);
        end
    end
end