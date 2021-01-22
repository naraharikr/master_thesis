% Implementation of average-consensus algorithms proposed 
% in FROST over arbitrary digraphs
%
%
% Algortithms proposed here assumes column-stochastic weight 
% matrices and synchronous updates
%% START

clc; clear; close;
% column-stochastic weight matrix
B = [1/3  0   0  1/2  0;
     1/3 1/3  0   0   0;
     1/3 1/3 1/2  0  1/3;
      0   0   0  1/2 1/3;
      0  1/3 1/2  0  1/3];
  
x = [1 2 3 4 5]';  %initial node values
alpha = [2 2 2 2 2]'; 
a = [5 5 1 5 4]'; %demand in node
v = ones(5,1);

% private cost function
syms y beta rho
f(y,beta,rho) = 1/2*beta*(y-rho)^2;
df = compute_gradient(f,y);

key = '1 Pushsum |2 Subgradient-push |3 ADD-OPT/Push-DIGing |4 AB Algortihm';
algorithm = input(key);

%% Pushsum Consensus
if (algorithm == 1)
   pushsum_z = [0 x0'];
   itr = 30;
   for k=1:itr
       x = B*x;
       v = B*v;
       z = x./v;
       pushsum_z=[pushsum_z; k z'];
   end
   figure(1);
   plot(0:itr,pushsum_z(:,2:length(B)+1));
   title('Pushsum Consensus: Values at each node vs Number of iterations');
   xlabel('Number of iterations');
   ylabel('Value at each node');
end
%% Subgradient-Push
if (algorithm == 2)
   z = [3 1 1 1 1]';
   SGDpush_z = [0 x'];
   itr = 50; step = 1;
   for k = 1:itr
       dfz = double(subs(df, {y,beta,rho}, {z,alpha,a}));
       v = B*v;
       x = B*x - step*dfz;
       z = x./v;
       step = 1/k;
       % update alpha by backtrace line search
       %Xk = x-x0;
       %dk = -Xk;
       %F = @(x)0.5*(x-x0)'*(x-x0);
       %alpha = backtrack(alpha,Xk,dk,F); 
       SGDpush_z=[SGDpush_z; k z'];
   end
   figure(2);
   plot(0:itr,SGDpush_z(:,2:length(B)+1));
   title('Subgradient-Push: Values at each node vs Number of iterations');
   xlabel('Number of iterations');
   ylabel('Value at each node');
end

%% ADD_OPT/Push-DIGing
% if (algorithm == 3)
%     ADDOPT_z = [0 x0'];
%     itr = 30; alpha = 1e-4;
%     temp = zeros(length(B),itr);
%     temp(:,1) = z;
%     y = x0 - x0;
%     for k=1:itr
%         v = B*v;
%         x = B*x - alpha*y;
%         z = x./v;
%         temp(:,k+1) = z; 
%         ADDOPT_z=[ADDOPT_z; k z'];
%         y = B*y + (z-x0) - (temp(:,k)-x0);
%     end
%    figure(3);
%    plot(0:itr,ADDOPT_z(:,2:length(B)+1));
%    title('ADD-OPT/Push-DIGing: Values at each node vs Number of iterations');
%    xlabel('Number of iterations');
%    ylabel('Value at each node');
% end