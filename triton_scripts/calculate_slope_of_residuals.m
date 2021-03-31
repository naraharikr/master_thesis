%
%
% Extract data from combinedLogs, meshplot the data and save the
% figures as animation
%
%% START
clear; clc; close all;
arg_step = [linspace(0.0001,0.0009,9) linspace(0.001,0.009,9) ...
    linspace(0.01,0.09,9) 0.1];
arg_delay = 1:1:10;
str_step = strrep(string(arg_step),'.','_');
n_delay = length(arg_delay);
n_step = length(arg_step);
rDirec = "test_logs/combined_logs";
sDirec = "../assets/matvar";
param_struct = repmat(struct('step',{},'delay',{},'convergence',{},...
    'residual',{}),10,1);
for m=1:n_step
    fn = sprintf("compiledLog_step_%s_itr_2000",str_step(m));
    fp = sprintf("%s.mat",fullfile(rDirec,fn));
    load(fp);
    param_struct = [param_struct; result_table];
end

%% Calcualte slope of residuals for convergence delays
len_param_struct = length(param_struct);
column_len = 1:n_delay:len_param_struct;
row_len = length(param_struct(1).residual);
res_slope = zeros(n_delay,2,n_step);
for j=1:n_step
    init_val = column_len(j);
    end_val = column_len(j)+9;
    
    x1 = 100*ones(n_delay,1);
    x2 = 300*ones(n_delay,1);
    for i=init_val:end_val
        avg_mse(:,i) = param_struct(i).residual;
    end
    y1 = avg_mse(100,init_val:end_val)';
    y2 = avg_mse(300,init_val:end_val)';
    num = log(y2./y1);
    den = x2-x1;
    slope = num./den;
    % replace Inf, NaN and diverging entries with zeros
    slope(~isfinite(slope)) = 0;
    slope(slope>0) = 0;
    res_slope(:,1,j) = arg_step(j);
    res_slope(:,2,j) = slope;
end

fn = sprintf("async_addopt_residuals_and_slopes.mat");
fp = fullfile(sDirec,fn);
save(fp,'n_delay','n_step','arg_step','res_slope','avg_mse','row_len','column_len');

%% END