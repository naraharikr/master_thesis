%
%
% Implementation of ADD-OPT consensus algorithm with Asynchronous networks
% (only switchings in the topology)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup environment and add directory to path to access common functions
clc; clear; close all;
access_func_directory = fileparts(pwd);
addpath(access_func_directory);

%% START: Push-DIGing (ADD-OPT Algorithm With Switchings)

% column-stochastic weight matrix
B = [1/3 0 0 1/2 0; 1/3 1/3 0 0 0; 1/3 1/3 1/2 0 1/3; 0 0 0 1/2 1/3; 0 1/3 1/2 0 1/3];
% B = [1/3 1/4 1/4 0; 1/3 1/4 1/4 1/3; 1/3 1/4 1/4 1/3; 0 1/4 1/4 1/3];
n = length(B);
x = [4 1 5 2 3]';
v = ones(n,1);
y = zeros(n,1);
alpha = [2 4 5 3 1]';
z = v./x;

% initialization for network with switchings
xs_0 = x;
xs_k = x; ys_k = y;
vs_k = v; zs_k = z;
xs_arxiv = xs_k; ys_arxiv = ys_k;
zs_arxiv = zs_k; vs_arxiv = vs_k;

% initialization of cost function
gradientEstimatorswitching = zeros(n,1);
for m=1:n
    ys_k(m)=compute_gradient(xs_0(m),xs_0(m),alpha(m));
end
gradientEstimatorswitching_arxiv=ys_k;

% consensus value (linear convergence to optimal value of x)
average_x = mean(xs_0);
optimal_x = sum(alpha.*xs_0)/sum(alpha)

%% Push-DIGing Algorithm
    itr = 1000; step=0.1;
    % create time-varyging graph for given topology
    [B_timeVariant,n_timeVariant] = generate_timevariant_weight_matrix(B);
    n_temp = n_timeVariant;
    index = randperm(n_temp);
    
    for i=1:itr
        if (n_temp==0)
            n_temp = n_timeVariant;
        elseif (n_temp>=1)
            % randomly pick a weight matrix from 'B_timeVariant'
            [Bs_k, updated_idx] = select_timevariant_weightMatrix(B_timeVariant,index);
            n_temp = n_temp-1;
        end
        Bs_arxiv(:,:,i) = Bs_k;
        % Values of 'v' with switchings
        vs_k = Bs_k*vs_k;
        diag_vs_k = diag(vs_k);
        vs_arxiv = [vs_arxiv vs_k];
        
        % Values of 'x' with switchings
        xs_k = Bs_k*(xs_k - step*ys_k);
        xs_arxiv = [xs_arxiv xs_k];
        
        % Values of 'z' with switchings
        zs_k = inv(diag_vs_k)*xs_k;
        zs_arxiv = [zs_arxiv zs_k];
        
        for j=1:n
            gradientEstimatorswitching(j) = ...
                                compute_gradient(zs_k(j),xs_0(j),alpha(j));
        end
        ys_k = Bs_k*ys_k + gradientEstimatorswitching ...
                                 - gradientEstimatorswitching_arxiv(:,end);
        ys_arxiv = [ys_arxiv ys_k];
        gradientEstimatorswitching_arxiv = ...
             [gradientEstimatorswitching_arxiv gradientEstimatorswitching];
    end
    
    async_addopt_switching_residual_arxiv = ...
             compute_residual(zs_arxiv,optimal_x,'async_addopt_switching');

%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,vs_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$v_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(2); hold on; box on;
plot(0:itr,xs_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$x_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(3); hold on; box on;
plot(0:itr,ys_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$y_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(4); hold on; box on;
plot(0:itr,zs_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Push-DIGing (ADD-OPT with switchings) Algorithm: Switching networks'); 
plot([0,itr],[optimal_x,optimal_x], 'r-.')
plot([0,itr],[average_x,average_x], 'b-.')

figure(5); hold off; box on;
plot(0:itr,async_addopt_switching_residual_arxiv);
set(gca, 'YScale', 'log')
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$\frac{1}{n}\sum_{i=1}^{n}(z^{i}_k - x^{*})^{2}$ at each iteration','fontsize',14); 
set(yl, 'Interpreter', 'latex');
title('Push-DIGing Implementation with Quadratic Cost Function');

% Display optimal_x and final z
fprintf('\nPush-DIGing Consensus result\n');
display(zs_k);

%% END: Push-DIGing (ADD-OPT Algorithm With Switchings)