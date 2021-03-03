%% START
function [residual] = compute_residual(z_arxiv,opt_x,algo_name,delay)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Compute the average residual at each agent for given algorithm
% and save a copy to '../assets/matvar/'
% 
% INPUT: z_arxiv = ratio zk vector (no_of_agents X iterations)
%        opt_x = optimal value of x (Scalar)
%        algo_name = algorithm name as string
%
% OUTPUT: residual_arxiv = residual vector (1 X iteration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Macro defnitions
%
% Synchronous networks with no delays
SYNC_ADDOPT = 'sync_addopt'; 
SYNC_FROST = 'sync_frost';   
%
% Asynchronous networks with only delays and no switchings
ASYNC_ADDOPT_DELAY = 'async_addopt_delay';
ASYNC_FROST_DELAY = 'async_frost_delay';
%
% Asynchronous networks with delays and switchings
ASYNC_ADDOPT_SWITCHING_AND_DELAY = 'async_addopt_switching_and_delay';
ASYNC_FROST_SWITCHING_AND_DELAY = 'async_frost_switching_and_delay';
% 
% % END-Macro defnitions

%% function [residual] = compute_residual(z_arxiv,opt_x,algo_name,delay)
%
[n,itr]=size(z_arxiv);
residual = zeros(1,itr);
for i=1:itr
    sum=0;
    for j=1:n
        mean_square_error = (z_arxiv(j,i)-opt_x)^2;
        sum = sum + mean_square_error; 
    end
    residual(i)=sum/n;
end
%
% save 'residual' variable to '../assets/matvar/' with respective names
%
if (nargin==3) 
    % for synchronous networks
    if(strcmp(algo_name,SYNC_ADDOPT))
        str_algo = algo_name;
    elseif(strcmp(algo_name,SYNC_FROST))
        str_algo = algo_name;
    end
    file_name_in_parts = [str_algo, "residual_arxiv"];
elseif (nargin>3)
    % in case of ayshronous networks with just delays
    if(strcmp(algo_name,ASYNC_ADDOPT_DELAY))
        str_algo = algo_name;
    elseif(strcmp(algo_name,ASYNC_FROST_DELAY))
        str_algo = algo_name;
    end
    file_name_in_parts = [str_algo, "blocks", num2str(delay)];
end

% % generate the respective string names to store data
    file_name = join(file_name_in_parts,"_");
    file_path = sprintf('../assets/matvar/%s.mat',file_name);
    save(file_path,'residual');
    
end
%% END