%
%
% Implementation of ADDOPT/Push-DIGing consensus algorithm
% with Asynchronous networks 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup environment and add directory to path to access common functions
clc; clear; close all;
access_func_directory = fileparts(pwd);
addpath(access_func_directory);

%% START: Asynchronous ADD-OPT Algorithm

clc; clear; close all;
% column-stochastic weight matrix
B = [1/3 0 0 1/2 0; 1/3 1/3 0 0 0; 1/3 1/3 1/2 0 1/3; 0 0 0 1/2 1/3; 0 1/3 1/2 0 1/3];
n = length(B);
xd = [4 1 5 2 3]';
vd = ones(n,1);
yd = zeros(n,1);
alpha = [2 4 5 3 1]';
zd = vd./xd;

% initialization for network with delays
maxDelay = 1;
vd_k = [vd' zeros(1,n*maxDelay)]';
xd_k = [xd' zeros(1,n*maxDelay)]';
yd_k = [yd' zeros(1,n*maxDelay)]';
xd_0 = xd_k; xd_arxiv = xd;
yd_0 = yd_k; yd_arxiv = yd;
zd_arxiv = zd; vd_arxiv = vd;

% initialization of cost function
n_aug = n+(n*maxDelay);
alpha = [alpha' zeros(1,n*maxDelay)]';
gradientEstimatordelay = zeros(n_aug,1);
for m=1:n_aug
    yd_0(m)=compute_gradient(xd_0(m),xd_0(m),alpha(m));
end
gradientEstimatordelay_arxiv=yd_0;

% consensus value
average_x = mean(xd_0);
optimal_x = sum(alpha.*xd_0)/sum(alpha)

%% ADD-OPT (Async) Algorithm
    itr = 200; step=0.01;
    for i=1:itr
        % create weight matrix with delay
        B_aug = aug_weight_matrix(B,maxDelay);

        vd_k = B_aug*vd_k;
%         diag_vd_k = diag(vd_k);
        vd_arxiv = [vd_arxiv vd_k(1:n)];
        
        xd_k = B_aug*xd_k - step*yd_k;
        xd_arxiv = [xd_arxiv xd_k(1:n)];
        
%         zd_k = inv(diag_vd_k)*xd_k;
        zd_k = xd_k./vd_k;
        zd_arxiv = [zd_arxiv zd_k(1:n)];
        
        for j=1:n_aug
            gradientEstimatordelay(j)=compute_gradient(zd_k(j),xd_0(j),alpha(j));
        end
        yd_k = B_aug*yd_k+gradientEstimatordelay-gradientEstimatordelay_arxiv(:,end);
        gradientEstimatordelay_arxiv=[gradientEstimatordelay_arxiv gradientEstimatordelay];
    end
    
    async_addopt_residual_arxiv=compute_residual(zd_arxiv,optimal_x,'async_addopt');

%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,vd_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$v_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(2); hold on; box on;
plot(0:itr,xd_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$x_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(3); hold on; box on;
plot(0:itr,zd_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('ADD-OPT Algorithm: Asynchronous networks'); 
plot([0,itr],[optimal_x,optimal_x], 'r-.')
plot([0,itr],[average_x,average_x], 'b-.')

figure(4); hold off; box on;
plot(0:itr,async_addopt_residual_arxiv);
set(gca, 'YScale', 'log')
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$\frac{1}{n}\sum_{i=1}^{n}(z^{i}_k - x^{*})^{2}$ at each iteration','fontsize',14); 
set(yl, 'Interpreter', 'latex');
title('ADDOPT Implementation with Quadratic Cost Function');

% Display optimal_x and final z
fprintf('\nADD_OPT/Push-DIGing Consensus result\n');
display(zd_k(1:n));

%% END: Asynchronous ADD-OPT Algorithm