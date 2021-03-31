%
%
% Mesh plot the data with Delay in X-axis, Stepsize in Y-axis, and
% Convergence rate in Z-axis and save as .mp4 files
%
%
%% Load .mat file necessary data
clc; clear; close all;
load('../assets/matvar/async_addopt_residuals_and_slopes.mat');

%% START: Meshplot with Animation

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

%% Meshplot:01 - Stepssize [0.0001 0.001]
OptionZ.FrameRate=30;OptionZ.Duration=10;OptionZ.Periodic=true;

figure(1); box on; grid on;
set(gca,'DefaultTextInterpreter','latex');
s1=mesh(xvec,yvec(:,:,1),zvec(:,:,1));
set(s1,'FaceColor','interp');
x1=xlabel('Delays $\rightarrow$'); xticks(0:2:10);
set(x1,'Interpreter','latex','FontSize',12);
y1=ylabel('$\leftarrow$ Step-size'); 
yticks([0.0002 0.0004 0.0006 0.0008]);
yticklabels({'0.0002','0.0004','0.0006','0.0008'});
set(y1,'Interpreter','latex','FontSize',12);
z1=zlabel('Convergence rate');
set(z1,'Interpreter','latex','FontSize',12);
t1 = title('Slope of residuals, $\alpha=0.0001, \cdots, 0.001$');
set(t1,'Interpreter','latex','FontSize',14);
% save as animation
azimuth_1 = [-30:-10:-80 -100:-10:-140];
elevation_1 = [30 30 35 35 30 30 20 20 30 30 30];
view_points_1(:,1)=azimuth_1';
view_points_1(:,2)=elevation_1';
CaptureFigVid(view_points_1,'async_addopt_stepsize_1e4_1e3',OptionZ);

%% Meshplot:02 - Stepssize [0.001 0.01]
close all;
figure(2); box on; grid on;
set(gca,'DefaultTextInterpreter','latex');
s1=mesh(xvec,yvec(:,:,2),zvec(:,:,2));
set(s1,'FaceColor','interp');
x1=xlabel('Delays $\rightarrow$'); xticks(0:2:10);
set(x1,'Interpreter','latex','FontSize',12);
y1=ylabel('$\leftarrow$ Step-size'); 
yticks([0.002 0.004 0.006 0.008 0.01]);
yticklabels({'0.002','0.004','0.006','0.008'});
set(y1,'Interpreter','latex','FontSize',12);
z1=zlabel('Convergence rate');
set(z1,'Interpreter','latex','FontSize',12);
t1 = title('Slope of residuals, $\alpha=0.001, \cdots, 0.01$');
set(t1,'Interpreter','latex','FontSize',14);

azimuth_2 = [-80 -80 -80 -80 -80 -80 -80 -70 -60 -50 -40 ...
    -30 -20 -10 -10 -10 -10 -10 -20 -30 -40 -50];
elevation_2 = [80 70 60 50 40 30 20 20 20 20 20 ...
    20 20 20 15 10 15 20 20 20 15 30];
view_points_2=zeros(length(azimuth_2),2);
view_points_2(:,1)=azimuth_2';
view_points_2(:,2)=elevation_2';
CaptureFigVid(view_points_2,'async_addopt_stepsize_1e3_1e2',OptionZ);

%% Meshplot:03 - Stepssize [0.01 0.1]
close all;
figure(3); box on; grid on;
set(gca,'DefaultTextInterpreter','latex');
s1=mesh(xvec,yvec(:,:,3),zvec(:,:,3));
set(s1,'FaceColor','interp');
x1=xlabel('Delays $\rightarrow$'); xticks(0:2:10);
set(x1,'Interpreter','latex','FontSize',12);
y1=ylabel('$\leftarrow$ Step-size'); 
yticks([0.02 0.04 0.06 0.08 0.1]);
yticklabels({'0.02','0.04','0.06','0.08','0.1'});
set(y1,'Interpreter','latex','FontSize',12);
z1=zlabel('Convergence rate');
set(z1,'Interpreter','latex','FontSize',12);
t1 = title('Slope of residuals, $\alpha=0.01, \cdots, 0.1$');
set(t1,'Interpreter','latex','FontSize',14);

azimuth_3 = [-30 -40 -50 -60 -80 -60 -50 -40 ...
    -30 -20 -10 -20 -10 -30 -40];
elevation_3 = 15*ones(1,length(azimuth_3));
view_points_3=zeros(length(azimuth_3),2);
view_points_3(:,1)=azimuth_3';
view_points_3(:,2)=elevation_3';
CaptureFigVid(view_points_3,'async_addopt_stepsize_1e2_1e1',OptionZ);

%% END: Meshplot with Animation