%
%
% Implementation of Subgradient-Push consensus algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup environment and add directory to path to access common functions
clc; clear; close all;
access_func_directory = fileparts(pwd);
addpath(access_func_directory);

%% START: Subgradient-Push Algorithm

% column-stochastic weight matrix
B = [1/3 0 0 1/2 0; 1/3 1/3 0 0 0; 1/3 1/3 1/2 0 1/3; 0 0 0 1/2 1/3; 0 1/3 1/2 0 1/3];
  
% initialization
n = length(B);
x = [4 1 5 2 3]';
v = ones(n,1);
z = v./x; 

% initialization for cost function
alpha = [2 4 5 3 1]';
x0 = x; x_arxiv = x;
z0 = z; z_arxiv = z;
v_arxiv = v;
gradientEstimator = zeros(n,1);
for i=1:n
    gradientEstimator_arxiv(i)=compute_gradient(z0(i),x0(i),alpha(i));
end
gradientEstimator_arxiv = zeros(n,1);

% consensus value = optimal_x
average_x = mean(x);
optimal_x = sum(alpha.*x0)/sum(alpha)

%% Subgradient-Push algorithm
    itr = 2000; step = 1;
    for i=1:itr
        v = B*v; v_arxiv = [v_arxiv v];
        
        x = B*x - step*gradientEstimator_arxiv(:,end); 
        x_arxiv = [x_arxiv x];
        
        z = x./v; z_arxiv = [z_arxiv z];
        for j=1:n
            gradientEstimator(j)=compute_gradient(z(j),x0(j),alpha(j));
        end
        gradientEstimator_arxiv = ...
                               [gradientEstimator_arxiv gradientEstimator]; 
        % update step-size
        step = 1/i;
    end
    
%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,z_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$x^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(2); hold on; box on;
plot(0:itr,z_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$v^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(3); hold on; box on;
plot(0:itr,z_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Synchronous networks: Subgradient-Push'); 
plot([0,itr],[optimal_x,optimal_x], 'r-.')
plot([0,itr],[average_x,average_x], 'b-.')
hold off;

%% Display consensus result
fprintf('\nSubgradient-Push Consensus result\n');
display(z);
 
%% END: Subgradient-Push Algorithm