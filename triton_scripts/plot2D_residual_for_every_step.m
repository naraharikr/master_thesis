%
%
% Plot the residuals for each step size for all delays 
% [1 2 3 4 5 6 7 8 9 10]
%
%% Load .mat file necessary data
clc; clear; close all;
load('../assets/matvar/async_addopt_residuals_and_slopes.mat');

%% START
fig_count = 1;

for j=1:n_step
    init_val = column_len(j);
    end_val = column_len(j)+9;

    figure(fig_count); hold on; box on;
    for i=init_val:end_val
        plot(1:row_len,avg_mse(:,i)');
    end
    set(gca, 'YScale', 'log');
    xl=xlabel('Iterations $\rightarrow$');
    set(xl, 'Interpreter', 'latex','FontSize',12);
    yl=ylabel('$\frac{1}{n}\sum_{i=1}^{n}(z^{i}_k - x^{*})^{2}$ at each iteration');
    set(yl, 'Interpreter', 'latex','FontSize',12);
    l1= legend('delay = 1','delay = 2','delay = 3','delay = 4','delay = 5',...
             'delay = 6','delay = 7','delay = 8','delay = 9','delay = 10');
    set(l1,'Interpreter','latex','Location','best','NumColumns',2,'FontSize',8);
    t1 = sprintf('Residual for different delays, $\\alpha$ = %.d', arg_step(j));
    title(t1,'Interpreter','latex','FontSize',14);
    hold off;

    fig_count = fig_count+1;
    figure(fig_count); hold on; box on;
    set(0, 'DefaultTextInterpreter', 'latex');
    plot(1:n_delay,res_slope(:,2,j),'bx');
    ylim([-0.1 0.1]); xticks(1:10);
    xl=xlabel('Delays in the network $\rightarrow$');
    set(xl, 'Interpreter', 'latex','FontSize',12);
    yl=ylabel('Slope of residuals at $k^{th}$ delay');
    set(yl, 'Interpreter', 'latex','FontSize',12);
    t2 = sprintf('Slope of residuals, $\\alpha$ = %.d', arg_step(j));
    title(t2,'Interpreter','latex','FontSize',14);
    fig_count = fig_count+1;
end

%% END