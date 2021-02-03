% Implementation of average-consensus algorithms with Pushsum 
% and Subgradient-push algorithms
%
%
% Algortithms proposed here assumes column-stochastic weight 
% matrices and synchronous updates among agents in the distributed
% network to find global minima.
%% START: Consensus with Synchronous Updates

clc; clear; close;
% column-stochastic weight matrix
B = [1/3  0   0  1/2  0;
     1/3 1/3  0   0   0;
     1/3 1/3 1/2  0  1/3;
      0   0   0  1/2 1/3;
      0  1/3 1/2  0  1/3];
  
x = [1 2 3 4 5]';  %initial node values
alpha = [2 4 5 3 1]'; 
a = [4 3 2 5 4]';  %demand in node
v = ones(5,1);

% private cost function
syms y beta rho
f(y,beta,rho) = 1/2*beta*(y-rho)^2;
df = compute_gradient(f,y);

% select algorithm
select = 'Choose consensus algorithm:\n(1) Pushsum, (2) Subgrad-push';
algorithm = input(select);

%% Pushsum Consensus
if (algorithm == 1)
   fprintf('\nPushsum Consensus result\n');
   pushsum_z = [0 x'];
   itr = 30;
   for k=1:itr
       x = B*x;
       v = B*v;
       z = x./v;
       pushsum_z=[pushsum_z; k z'];
   end
   figure(1);
   plot(0:itr,pushsum_z(:,2:length(B)+1));
   title('Pushsum: consensus with synchronous updates');
   xlabel('Number of iterations'); ylabel('Value at each node');
   display(pushsum_z(k+1,2:length(B)+1)');
end
%% Subgradient-Push
if (algorithm == 2)
   fprintf('\nSubgradient-Push Consensus result\n');
   itr = 100; step = 1; z = [3 1 1 1 1]'; 
   SGDpush_z = [0 x'];
   for k = 1:itr
       dfz = double(subs(df, {y,beta,rho}, {z,alpha,a}));
       v = B*v;
       x = B*x - step*dfz;
       z = x./v;
       step = 1/k;
       % update alpha by backtrace line search
       % Xk = double(subs(f, {y,beta,rho}, {x,alpha,a}));
       % dk = double(subs(df, {y,beta,rho}, {x,alpha,a}));
       % step = backtrack(step,Xk,dk,f(y,beta,rho)); 
       SGDpush_z=[SGDpush_z; k z'];
   end
   figure(2);
   plot(0:itr,SGDpush_z(:,2:length(B)+1));
   title('Subgradient-Push: Distributed network with Synchronous Update');
   xlabel('Number of iterations');  ylabel('Value at each node');
   display(SGDpush_z(k+1,2:length(B)+1)');
end

%% END: Consensus with Synchronous Updates