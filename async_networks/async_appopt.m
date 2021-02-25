%
%
% Implementation of ADDOPT/Push-DIGing consensus algorithm
% with Synchronous networks 
%
%
%% START: ADDOPT/Push-DIGing Algorithm (Asynchronous N/w)

clc; clear; close all;
% column-stochastic weight matrix
% B = [1/3  0   0  1/2  0;
%      1/3 1/3  0   0   0;
%      1/3 1/3 1/2  0  1/3;
%       0   0   0  1/2 1/3;
%       0  1/3 1/2  0  1/3];
B = [0.5 0.5 0; 0 0.5 0.5; 0.5 0 0.5];
% initialization
n = length(B);
x = randi([1 10],n,1);%[4 1 5 2 3]';
v = ones(n,1);
y = zeros(n,1); 
z = v./x; zd_arxiv = z;

% initialization of asynchronous variables
delay = 1;
xd_k = [x' zeros(1,n*delay)]';
vd_k = [v' zeros(1,n*delay)]';

B_aug = zeros(n+n*delay);
B_diag = diag(B);
for i=1:length(B)
    B_aug(i,i) = B(
end
aug_diag = diag(diag(B));
%B_aug = B(n+n*delay, n+n*delay);
% B(n+delay,n+delay) = 0;

% for j=1:100
%     vd_k = B*vd_k;
%     xd_k = B*xd_k;
%     zd_k = xd_k./vd_k;
%     zd_arxiv = [zd_arxiv zd_k(1:n)];
% end

% plot(0:j,zd_arxiv);
% initialization for cost function
% alpha = [2 4 5 3 1]';
% x_0 = x; y0 = y;
% z_arxiv = z;
% gradientEstimator = zeros(n,1);
% for i=1:n
%     y0(i)=compute_gradient(x_0(i),x_0(i),alpha(i));
% end
% gradientEstimator_arxiv=y0;

% consensus value
% average_x = mean(x);
% optimal_x = sum(alpha.*x_0)/sum(alpha)

%% ADD_OPT/Push-DIGing
%     itr = 200; step = 0.01;
%     for i=1:itr
%         v = B*v;
%         x = B*x - step*y;
%         z = x./v; 
%         z_arxiv=[z_arxiv z];
%         for j=1:n
%             gradientEstimator(j)=compute_gradient(z(j),x_0(j),alpha(j));
%         end
%         y = B*y+gradientEstimator-gradientEstimator_arxiv(:,end);
%         gradientEstimator_arxiv=[gradientEstimator_arxiv gradientEstimator];
%     end

%% Plots
% set(0, 'DefaultTextInterpreter', 'latex')
% set(gca, 'TickLabelInterpreter', 'latex')
% 
% figure(1); hold on; box on;
% plot(0:itr,z_arxiv);
% xl=xlabel('Number of iterations','fontsize',14); set(xl, 'Interpreter', 'latex');
% yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
% title('ADD-OPT/Push-DIGing: Synchronous networks'); 
% plot([0,itr],[optimal_x,optimal_x], 'r-.')
% plot([0,itr],[average_x,average_x], 'b-.')
% hold off;
% 
% % Display optimal_x and final z
% fprintf('\nADD_OPT/Push-DIGing Consensus result\n');
% display(z);
%  
%% END: ADDOPT/Push-DIGing Algorithm