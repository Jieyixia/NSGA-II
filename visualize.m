% % visualization 只适用于一维的情况
% p_set = unique(p_set);
% p_f1 = F{1}(p_set);
% p_f2 = F{2}(p_set);
% figure
% plot(p_set, p_f1, 'o', p_set, p_f2, '*')
% 
% hold on
% x = (linspace(0, 2, 1000))';
% y1 = F{1}(x); 
% y2 = F{2}(x);
% plot(x, y1, '-.', x, y2, '-')
% legend('pf1', 'pf2', 'f1 = x^2', 'f2 = (x - 2)^2')