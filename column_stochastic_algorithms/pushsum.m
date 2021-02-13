%
%
% Implementation of Pushsum consensus algorithm
%
%
%% START: Pushusm Consensus Algorithm

clc; clear; close all;

% column-stochastic weight matrix
B = [1/3  0   0  1/2  0;
     1/3 1/3  0   0   0;
     1/3 1/3 1/2  0  1/3;
      0   0   0  1/2 1/3;
      0  1/3 1/2  0  1/3];
% Initialization
n = length(B);
x = [-4 1 0 -2 3]';
v = ones(n,1);
z = x./v;
pushsum_z = z;

% consensus value
average_x = mean(x);

%% Pushsum Consensus
   fprintf('\nPushsum Consensus result\n');
   itr = 50;
   for k=1:itr
       x = B*x;
       v = B*v;
       z = x./v;
       pushsum_z=[pushsum_z z];
   end
   
%% Plot Results
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; 
plot(0:itr,pushsum_z);
xl=xlabel('Number of iterations','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Pushsum Consensus: Synchronous networks'); 
plot([0,itr],[average_x,average_x], 'b-.')
hold off;

% Display optimal_x and final z
fprintf('\nADD_OPT/Push-DIGing Consensus result\n');
display(z);

%% END: Pushusm Consensus Algorithm