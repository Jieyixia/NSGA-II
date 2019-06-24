function plot_pareto(pareto_front, p_f, t)

figure
plot(pareto_front(:, 1), pareto_front(:, 2), 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'r')
hold on 
plot(p_f(:, 1), p_f(:, 2), '*')
title(['No.', num2str(t), 'th iteration'])
end