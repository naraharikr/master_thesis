%
% Mesh plot the data with Delay in X-axis, Stepsize in Y-axis, and
% Convergence rate in Z-axis
%
% NOTE: To save the plotted graphs as animation files (.mp4 format only)
%       run 'plot3D_with_animation.m'
%
%% Load .mat file necessary data
clc; clear; close all;
load('../assets/matvar/async_addopt_residuals_and_slopes.mat');

%% START: Meshplot without Animation

% create 10x10 xaxes with same column entries
xvec=meshgrid(1:1:n_delay);
% create 10x10 yaxes with same row entries
for i=1:n_delay
    yvec(:,i,1)=arg_step(1:10);  %from_0_0001_to_0_001
    yvec(:,i,2)=arg_step(10:19); %from_0_001_to_0_01
    yvec(:,i,3)=arg_step(19:28); %from_0_01_to_0_1
end
% create 10x10 zaxes with corresponding x and y
for i=1:n_delay
    zvec(:,i,1)=res_slope(i,2,1:10);  %from_0_0001_to_0_001
    zvec(:,i,2)=res_slope(i,2,10:19); %from_0_001_to_0_01
    zvec(:,i,3)=res_slope(i,2,19:28); %from_0_01_to_0_1
end

%% Meshplots
param_ytick = ...
    [0.0002 0.0004 0.0006 0.0008 0.001 0.002 0.004 0.006 0.008 0.01 ...
    0.02 0.04 0.06 0.08 0.1];
param_yticklabel = ...
    {'0.0002','0.0004','0.0006','0.0008','0.001','0.002','0.004', ...
    '0.006','0.008','0.01','0.02','0.04','0.06','0.08','0.1'};
for i=1:3
    idx=[1 6 11]; fi=idx(i); li=fi+4;
    yaxes_val = param_ytick(fi:li);
    yaxes_label = param_yticklabel(fi:li);
    
    figure(i); box on; grid on;
    set(gca,'DefaultTextInterpreter','latex');
    s1=mesh(xvec,yvec(:,:,i),zvec(:,:,i));
    set(s1,'FaceColor','interp');
    x1=xlabel('Delays $\rightarrow$'); xticks(0:2:10);
    set(x1,'Interpreter','latex','FontSize',12);
    y1=ylabel('$\leftarrow$ Step-size'); yticks(yaxes_val);
    yticklabels(yaxes_label);
    set(y1,'Interpreter','latex','FontSize',12);
    z1=zlabel('Convergence rate');
    set(z1,'Interpreter','latex','FontSize',12);
    if i==1
        t1 = sprintf('Slope of residuals, $\\alpha$ = %.0d, $\\cdots$, %.0d',...
            arg_step(1), arg_step(10));
    elseif i==2
        t1 = sprintf('Slope of residuals, $\\alpha$ = %.0d, $\\cdots$, %.0d',...
            arg_step(10), arg_step(19));
    elseif i==3
        t1 = sprintf('Slope of residuals, $\\alpha$ = %.0d, $\\cdots$, %.0d',...
            arg_step(19), arg_step(28));
    end
    title(t1,'Interpreter','latex','FontSize',14);
end

%% END: Meshplot without Animation