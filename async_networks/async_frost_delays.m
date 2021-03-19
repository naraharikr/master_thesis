%
%
% Implementation of FROST algorithm with Asynchronous networks
% (only delays in communication)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup environment and add directory to path to access common functions
clc; clear; close all;
access_func_directory = fileparts(pwd);
addpath(access_func_directory);

%% START: FROST Algorithm with Delays (Async. N/w)

% Row-stochastic Weight Matrix
A = [0.5 0.25 0 0 0.25 0;0.25 0.5 0.25 0 0 0;0.5 0 0.5 0 0 0;
     0.25 0 0.25 0.25 0 0.25;0 0 0 0 0.5 0.5;0 0 0.25 0.25 0 0.5];
n = length(A);
x = [3 2 5 6 1 7]';
y = eye(n);
z = x./diag(y);
alpha = [1 3 2 1 4 1]';

% initialization for network with delays
maxDelay = 1;
n_aug = n+(n*maxDelay);
alpha = [alpha' zeros(1,n*maxDelay)]';
xd_k = [x' zeros(1,n*maxDelay)]';
zd_k = [z' zeros(1,n*maxDelay)]';
xd_0 = xd_k;  yd_k = eye(n_aug);  
% yd_k = y; yd_k(n_aug,n_aug) = 0;
xd_arxiv = x; yd_arxiv = diag(y);
zd_arxiv = z;

% initilization for cost function
imbalanceEliminatordelay = diag(yd_k);
gradientEstimatordelay = zeros(n_aug,1);
for p=1:n_aug
    zd_k(p)=compute_gradient(xd_0(p),xd_0(p),alpha(p));
end
for q=1:n_aug
    gradientEstimatordelay(q)=compute_gradient(xd_k(q),xd_0(q),alpha(q));
end
gradientEstimatordelay_arxiv = gradientEstimatordelay;

% consensus value = optimal_x
average_x = mean(xd_0);
optimal_x = sum(alpha.*xd_0)/sum(alpha)

%% FROST Algorithm (Delays)
itr = 200; step = 0.001;
% s = zeros(n_aug,1);
    for i=1:itr
        % create weight matrix with delay
        A_aug = gen_aug_weight_matrix(A,maxDelay);
%         s(:,i) = sum(A_aug,2);
        % Iterations of 'y' with delays
        yd_k = A_aug*yd_k;
        diag_yd_k = diag(yd_k);
        imbalanceEliminatordelay = [imbalanceEliminatordelay diag_yd_k];
        yd_arxiv = [yd_arxiv diag_yd_k(1:n)];
        
        % Iterations of 'x' with delays
        xd_k = A_aug*xd_k - step*zd_k;
        xd_arxiv = [xd_arxiv xd_k(1:n)];
        
        for j=1:n_aug
            gradientEstimatordelay(j) = ...
                                compute_gradient(xd_k(j),xd_0(j),alpha(j));
        end
        gradientEstimatordelay_arxiv = ...
                     [gradientEstimatordelay_arxiv gradientEstimatordelay];
        
        % Iterations of 'z' with delays
        imbalance_k_plus_1 = gradientEstimatordelay_arxiv(:,end)./imbalanceEliminatordelay(:,end);
        imbalance_k_plus_1(~isfinite(imbalance_k_plus_1)) = 0;
        imbalance_k = gradientEstimatordelay_arxiv(:,i)./imbalanceEliminatordelay(:,i);
        imbalance_k(~isfinite(imbalance_k)) = 0;
        zd_k = A_aug*zd_k + imbalance_k_plus_1 - imbalance_k;
%         zd_k = A_aug*zd_k ...
%                      + (gradientEstimatordelay_arxiv(:,end)./imbalanceEliminatordelay(:,end)) ...
%                      - (gradientEstimatordelay_arxiv(:,i)./imbalanceEliminatordelay(:,i));
%         zd_k(~isfinite(zd_k)) = 0;
        zd_arxiv = [zd_arxiv zd_k(1:n)];
    end
    % compute residual
%     async_frost_residual_arxiv = ...
%          compute_residual(xd_arxiv,optimal_x,'async_frost_delay',maxDelay);

%% Convergence Results & Residual Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,xd_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$x^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('FROST Algorithm: Delay networks'); 
plot([0,itr],[optimal_x,optimal_x], 'r:');
plot([0,itr],[average_x,average_x], 'b-.');

figure(2);hold on; box on;
plot(0:itr,imbalanceEliminatordelay(1:n,:));
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$y^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(3);hold on; box on;
plot(0:itr,zd_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$z^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
plot([0,itr],[0,0], 'r-.'); hold off;

% figure(4); hold off; box on;
% plot(0:itr,async_frost_residual_arxiv);
% set(gca, 'YScale', 'log')
% xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
% yl=ylabel('$\frac{1}{n}\sum_{i=1}^{n} (x^{i}_k - x^{*})^{2}$ (Avg. Mean-sqaure error)','fontsize',14); 
% set(yl, 'Interpreter', 'latex');
% title('FROST(Delay) with Quadratic Cost Function');

%% Display consensus result
fprintf('\nFROST Consensus result\n');
display(xd_arxiv(:,end));

%% END: FROST Algorithm with Delays (Async. N/w)