%
%
% Implementation of Subgradient-Push consensus algorithm
%
%
%% START: Subgradient-Push Algorithm

clc; clear; close all;
% column-stochastic weight matrix
B = [1/3  0   0  1/2  0;
     1/3 1/3  0   0   0;
     1/3 1/3 1/2  0  1/3;
      0   0   0  1/2 1/3;
      0  1/3 1/2  0  1/3];

% initialization
n = length(B);
x = [4 1 5 2 3]';
v = ones(n,1);
z = v./x; 
subgrad_Z = z;

% initialization for cost function
x0 = x; x_arxiv = x;
alpha = [2 4 5 3 1]'; z0 = z;
gradientEstimator = zeros(n,1);
for i=1:n
    gradientEstimator_arxiv(i)=compute_gradient(z0(i),x0(i),alpha(i));
end
gradientEstimator_arxiv = zeros(n,1);

% consensus value = optimal_x
average_x = mean(x);
optimal_x = sum(alpha.*x0)/sum(alpha);

%% Subgradient-Push algorithm
    itr = 2000; step = 1;
    for i=1:itr
        v = B*v;
        x = B*x - step*gradientEstimator_arxiv(:,end); x_arxiv = [x_arxiv x];
        z = x./v;
        for j=1:n
            gradientEstimator(j)=compute_gradient(z(j),x0(j),alpha(j));
        end
        gradientEstimator_arxiv=[gradientEstimator_arxiv gradientEstimator]; 
        subgrad_Z=[subgrad_Z z];
        step = 1/i;
        % update alpha by backtrace line search
        % Xk = double(subs(f, {y,beta,rho}, {x,alpha,a}));
        % dk = double(subs(df, {y,beta,rho}, {x,alpha,a}));
        % step = backtrack(step,Xk,dk,f(y,beta,rho)); 
    end
    
%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,subgrad_Z);
xl=xlabel('Number of iterations','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Subgradient-Push: Synchronous networks'); 
plot([0,itr],[optimal_x,optimal_x], 'r-.')
plot([0,itr],[average_x,average_x], 'b-.')
hold off;

% Display result
fprintf('\nSubgradient-Push Consensus result\n');
display(z);
 
%% END: Subgradient-Push Algorithm