%
%
% Implementation of ADDOPT/Push-DIGing consensus algorithm
%
%
%% START: ADDOPT/Push-DIGing Algorithm

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
y = zeros(n,1); 
z = v./x; ADDOPT_z = z;

% initialization for cost function
alpha = [2 4 5 3 1]';
x0 = x; y0 = y;
gradientEstimator = zeros(n,1);
for i=1:n
    y0(i)=compute_gradient(x0(i),x0(i),alpha(i));
end
gradientEstimator_arxiv=y0;

% consensus value
average_x = mean(x);
optimal_x = sum(alpha.*x0)/sum(alpha);

%% ADD_OPT/Push-DIGing
    itr = 200; step = 0.01;
    for i=1:itr
        v = B*v;
        x = B*x - step*y;
        z = x./v; 
        ADDOPT_z=[ADDOPT_z z];
        for j=1:n
            gradientEstimator(j)=compute_gradient(z(j),x0(j),alpha(j));
        end
        y = B*y+gradientEstimator-gradientEstimator_arxiv(:,end);
        gradientEstimator_arxiv=[gradientEstimator_arxiv gradientEstimator];
    end

%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,ADDOPT_z);
xl=xlabel('Number of iterations','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('ADD-OPT/Push-DIGing: Synchronous networks'); 
plot([0,itr],[optimal_x,optimal_x], 'r-.')
plot([0,itr],[average_x,average_x], 'b-.')
hold off;

% Display optimal_x and final z
fprintf('\nADD_OPT/Push-DIGing Consensus result\n');
display(z);
 
%% END: ADDOPT/Push-DIGing Algorithm