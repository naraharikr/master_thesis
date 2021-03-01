%
%
% Implementation of Projected subgradient consensus algorithm over
% directed graphs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup environment and add directory to path to access common functions
clc; clear; close all;
access_func_directory = fileparts(pwd);
addpath(access_func_directory);

%% START: Projected Subgradient Algorithm

clc; clear; close all;

% Row-stochastic Weight Matrix
A = [0.5 0.25 0 0 0.25 0;0.25 0.5 0.25 0 0 0;0.5 0 0.5 0 0 0;
     0.25 0 0.25 0.25 0 0.25;0 0 0 0 0.5 0.5;0 0 0.25 0.25 0 0.5];

n = length(A);
x = [3 2 5 6 1 7]';
y = eye(n);
alpha = [1 3 2 1 4 1]';

% initialization
x_arxiv = x; x0 = x;
y_arxiv = diag(y);

% initilization for cost function
gradientEstimator = x;
for k=1:n
    gradientEstimator(k)=compute_gradient(x(k),x0(k),alpha(k));
end
gradientEstimator_arxiv = gradientEstimator;

% consensus value = optimal_x
average_x = mean(x);
optimal_x = sum(alpha.*x0)/sum(alpha)

%% Projected Subgradient Algorithm
itr = 2000; step = 1;
for i=1:itr
    y = A*y;
    y_arxiv = [y_arxiv diag(y)];
    x = A*x - step*(gradientEstimator_arxiv(:,end)./y_arxiv(:,i));
    x_arxiv = [x_arxiv x];
    for j=1:n
        gradientEstimator(j)=compute_gradient(x(j),x0(j),alpha(j));
    end
    gradientEstimator_arxiv = [gradientEstimator_arxiv gradientEstimator];
    step = 1/i;
end

%% Plots and Results
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,x_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$x_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Projected Subgradient: Synchronous networks'); 
plot([0,itr],[optimal_x,optimal_x], 'r-.')
plot([0,itr],[average_x,average_x], 'b-.')
hold off;

% Display result
fprintf('\nProjected Subgradient Consensus result\n');
display(x);
 
%% END: Projected Subgradient Algorithm