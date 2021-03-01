%% START
function [residual_arxiv] = compute_residual(z_arxiv,opt_x,str)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Compute the average residual at each agent for given algorithm
% and save a copy to '../assets/matvar/'
% 
% INPUT: z_arxiv = ratio zk vector (no_of_agents X iterations)
%        opt_x = optimal value of x (Scalar)
%        str = algorithm name as string
%
% OUTPUT: residual_arxiv = residual vector (1 X iteration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% algorithm defnitions
SYNC_ADDOPT = 'sync_addopt'; 
SYNC_FROST = 'sync_frost';  
ASYNC_ADDOPT = 'async_addopt';
ASYNC_FROST = 'async_frost';

[n,itr]=size(z_arxiv);
residual_arxiv = zeros(1,itr);
for i=1:itr
    residual_sum=0;
    for j=1:n
        mean_square_error = (z_arxiv(j,i)-opt_x)^2;
        residual_sum = residual_sum + mean_square_error; 
    end
    residual_arxiv(i)=residual_sum/n;
end

% save variable to '../assets/matvar/'
if(strcmp(str,SYNC_ADDOPT))
    sync_addopt_residual_arxiv = residual_arxiv;
    save('../assets/matvar/sync_addopt_residual_arxiv');
elseif(strcmp(str,SYNC_FROST))
    sync_frost_residual_arxiv = residual_arxiv;
    save('../assets/matvar/sync_frost_residual_arxiv');
elseif(strcmp(str,ASYNC_ADDOPT))
    async_addopt_residual_arxiv = residual_arxiv;
    save('../assets/matvar/async_addopt_residual_arxiv');
elseif(strcmp(str,ASYNC_FROST))
    async_frost_residual_arxiv = residual_arxiv;
    save('../assets/matvar/async_frost_residual_arxiv');
end

end
%% END