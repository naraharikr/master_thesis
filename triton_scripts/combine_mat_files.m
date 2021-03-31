%% Compile 'triton_logs' and and save to a folder

clear; clc;
% used stepsize and delay
x1 = linspace(0.0001,0.0009,9);
x2 = linspace(0.001,0.009,9); 
x3 = linspace(0.01,0.09,9);
num_delay = 1:1:10;
num_alpha = [x1 x2 x3 0.1];
str_alpha = strrep(string(num_alpha),'.','_');
n_steps = length(num_alpha);
n_delay = length(num_delay);

sDirec = sprintf("test_logs/combined_logs/");
% create folder
if ~exist("combined_logs",'dir')
%     dp = fullfile();
    mkdir(sDirec);
end

for i=1:n_steps
    cflag = 1;
    rDirec = sprintf("test_logs/step_%s",str_alpha(i));
    for j=1:n_delay
        fn = sprintf("resultLog_delay_%d_step_%s_itr_2000",...
                                                num_delay(j),str_alpha(i));
        fp = fullfile(rDirec,fn);
        load(fp);
        if cflag==1
            % create a structure to store complied result
            result_table = repmat(struct('step',0,'delay',0,...
                                  'convergence',0,'residual',0),n_delay,1);
            cflag = 0;
        end
        result_table(j).step = num_alpha(i);
        result_table(j).delay = num_delay(j);
        result_table(j).convergence = cvrg_res;
        result_table(j).residual = residual;
        % store to compiled logs
        if (num_delay(j)==10)
            sf = sprintf("compiledLog_step_%s_itr_2000",str_alpha(i));
            sp = fullfile(sDirec,sf);
            save(sp,'result_table');
        end
    end
end