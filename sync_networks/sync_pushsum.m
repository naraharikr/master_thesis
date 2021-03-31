%
%
% Implementation of pushsum consensus algorithm
% with Synchronous networks 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup environment and add directory to path to access common functions
clc; clear; close all;
access_func_directory = fileparts(pwd);
addpath(access_func_directory);

%% START: Pushusm Consensus Algorithm

% column-stochastic weight matrix
B = [1/3 0 0 1/2 0; 1/3 1/3 0 0 0; 1/3 1/3 1/2 0 1/3; 0 0 0 1/2 1/3; 0 1/3 1/2 0 1/3];
  
% initialization
n = length(B);
x = [4 1 5 2 3]';
v = ones(n,1);
z = x./v;

x_arxiv = x; v_arxiv = v;
z_arxiv = z;

% consensus value = average_x
average_x = mean(x);

%% Pushsum Consensus
   fprintf('\nPushsum Consensus result\n');
   itr = 50;
   for k=1:itr
       x = B*x; x_arxiv=[x_arxiv x];
       v = B*v; v_arxiv=[v_arxiv v];
       z = x./v; z_arxiv=[z_arxiv z];
   end
   
%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

figure(1); hold on; box on;
plot(0:itr,x_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$x^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(2); hold on; box on;
plot(0:itr,v_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('$v^{i}_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');

figure(3); hold on; box on;
plot(0:itr,z_arxiv);
xl=xlabel('Iterations $\rightarrow$','fontsize',14); set(xl, 'Interpreter', 'latex');
yl=ylabel('Ratio $z_k$ at each node','fontsize',14); set(yl, 'Interpreter', 'latex');
title('Synchronous networks: Pushsum Consensus'); 
plot([0,itr],[average_x,average_x], 'b-.'); hold off;

%% Display consensus result
fprintf('\nPushsum Consensus result\n');
display(z);

%% END: Pushusm Consensus Algorithm