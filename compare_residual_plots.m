%
% This script plots the comparision of residuals between ADD-OPT
% and FROST in synchronous and asynchronous setup.
%
%% START

clc; clear; close all;
SYNC = 1; ASYNC = 2;

fprintf('Note: This script supports only ADD-OPT and FROST algorithms for comparision plots\n');
network = 'Choose network setup: (1)Synchronous (2) Asynchronous \n';
chosen_network = input(network);

if (chosen_network == SYNC)
    load('assets/matvar/sync_frost_residual_arxiv')
    load('assets/matvar/sync_addopt_residual_arxiv')
    endValue_sync_frost = length(sync_frost_residual_arxiv);
    endValue_sync_addopt = length(sync_addopt_residual_arxiv);
    if(endValue_sync_frost ~= endValue_sync_addopt)
        fprintf('Iterations of both algorithms should be same\n)');
        return
    else
        endValue = endValue_sync_frost;
    end
elseif (chosen_network == ASYNC)
    load('../assets/matvar/async_frost_residual_arxiv')
    load('../assets/matvar/async_addopt_residual_arxiv')
    endValue_async_frost = length(async_frost_residual_arxiv);
    endValue_async_addopt = length(async_addopt_residual_arxiv);
    if(endValue_async_frost ~= endValue_async_addopt)
        fprintf('Iterations of both algorithms should be same\n)');
        return
    else
        endValue = endValue_async_frost;
    end
end

%% Residual plot
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(1:endValue,sync_addopt_residual_arxiv,'b');
plot(1:endValue,sync_frost_residual_arxiv,'r');
set(gca, 'YScale', 'log'); xlim([0 endValue]);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Average MSE at each iteration','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Quadratic Cost Function, $f_i(x) = \frac{1}{2}{\alpha}_i(x-{\rho}_i)^{2}$');
legend('ADD-OPT Algorithm','FROST Algorithm')
hold off;

%% END