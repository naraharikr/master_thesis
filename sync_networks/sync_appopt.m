%
%
% Implementation of Accelerated Distributed Sirected Optimization(ADD-OPT) 
% consensus algorithm with Synchronous networks 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup environment and add directory to path to access common functions
clc; clear; close all;
access_func_directory = fileparts(pwd);
addpath(access_func_directory);

%% START: ADDOPT/Push-DIGing Algorithm

% column-stochastic weight matrix
B = [1/3 0 0 1/2 0; 1/3 1/3 0 0 0; 1/3 1/3 1/2 0 1/3; 0 0 0 1/2 1/3; 0 1/3 1/2 0 1/3];

% initialization
n = length(B);
x = [4 1 5 2 3]';
v = ones(n,1);
y = zeros(n,1); 
z = v./x;

% initialization for cost function
alpha = [2 4 5 3 1]';
x0 = x; x_arxiv = x;
y0 = y; y_arxiv = y;
z_arxiv = z; v_arxiv = v;
gradientEstimator = zeros(n,1);
for i=1:n
    y0(i)=compute_gradient(x0(i),x0(i),alpha(i));
end
gradientEstimator_arxiv=y0;

% consensus value
average_x = mean(x);
optimal_x = sum(alpha.*x0)/sum(alpha)

%% ADD_OPT/Push-DIGing
    itr = 200; step = 0.01;
    for i=1:itr
        v = B*v; 
        v_arxiv = [v_arxiv v];
        
        x = B*x - step*y; 
        x_arxiv = [x_arxiv x];
        
        z = x./v; 
        z_arxiv = [z_arxiv z];
        
        for j=1:n
            gradientEstimator(j)=compute_gradient(z(j),x0(j),alpha(j));
        end
        y = B*y+gradientEstimator-gradientEstimator_arxiv(:,end);
        y_arxiv = [y_arxiv y];
        gradientEstimator_arxiv = ...
                               [gradientEstimator_arxiv gradientEstimator];
    end
    
    sync_addopt_residual_arxiv = ...
                         compute_residual(z_arxiv,optimal_x,'sync_addopt');

%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,v_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$v^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(2); hold on; box on;
plot(0:itr,x_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$x^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(3); hold on; box on;
plot(0:itr,y_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$y^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(4); hold on; box on;
plot(0:itr,z_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Synchronous Networks: Accelerated Distributed Sirected Optimization (ADD-OPT)'); 
plot([0,itr],[optimal_x,optimal_x], 'r-.')
plot([0,itr],[average_x,average_x], 'b-.')

figure(5); hold on; box on;
plot(0:itr,sync_addopt_residual_arxiv);
set(gca, 'YScale', 'log')
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$\frac{1}{n}\sum_{i=1}^{n}(z^{i}_k - x^{*})^{2}$ at each iteration','fontsize',14); 
set(yl, 'Interpreter', 'latex');
title('ADDOPT Implementation with Quadratic Cost Function'); hold off;

%% Display optimal_x and final z
fprintf('\nADD_OPT/Push-DIGing Consensus result\n');
display(z);
 
%% END: ADDOPT/Push-DIGing Algorithm