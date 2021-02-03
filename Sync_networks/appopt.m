% Implementation of average-consensus algorithms using  
% ADDOPT/PushDIGing algorithm
%
%
% Algortithms proposed here assumes column-stochastic weight 
% matrices and synchronous updates among agents in the distributed
% network to find global minima.
%% START: ADDOPT/Push-DIGing Algorithm

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
ADDOPT = [0 x'];%to store result

% private cost function
syms w beta rho
f(w,beta,rho) = 1/2*beta*(w-rho)^2;
df = compute_gradient(f,w);

%% ADD_OPT/Push-DIGing
    fprintf('\nADD_OPT/Push-DIGing Consensus result\n');
    itr = 100; step = 1e-7;
    temp_dfz(:,1) = [3 4 5 6 7]';
    dfz_prv = [3 1 1 1 1]'; %initial z vector 
    y = double(subs(df, {w,beta,rho}, {x,alpha,a}));
    for k=1:itr
        v = B*v;
        x = B*x - step*y;
        z = x./v;
        dfz = double(subs(df, {w,beta,rho}, {z,alpha,a}));
        temp_dfz(:,k+1) = dfz;
        dfz_prv = double(subs(df, {w,beta,rho}, {temp_dfz(:,k),alpha,a}));
        y = B*y + dfz - dfz_prv;
        ADDOPT = [ADDOPT; k z'];
    end

%% Plot Results
   plot(0:itr,ADDOPT(:,2:length(B)+1));
   title('ADD-OPT/Push-DIGing: Values at each node vs No. of iterations');
   xlabel('Number of iterations');
   ylabel('Value at each node');
   display(ADDOPT(k+1,2:length(B)+1)');
   
%% END: ADDOPT/Push-DIGing Algorithm