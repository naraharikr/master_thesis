%% START
function [P_timeVariant,no_of_graphs] = ...
                                      generate_timevariant_weight_matrix(P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Generate different configurations of time variant weight matrices
% (P1,P2,....,Pn) from the given P matrix, such that union of selected
% configurations over bounded interval forms jointly strongly-connected
% digraph.
% 
% INPUT: P = original column-stochastic weight matrix
%
% OUTPUT: P_timeVariant = time-varying configuration of P
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% P1 = [1/2 1/2 0 0; 0 1/2 1/2 0; 1/2 0 1/2 0; 0 0 0 1];
% P2 = [1 0 0 0; 0 1/2 0 1/2; 0 1/2 1/2 0; 0 0 1/2 1/2];
% P3 = [1/2 0 0 0; 1/2 1/2 0 0; 0 1/2 1 0; 0 0 0 1];
% P4 = [1 0 1/2 0; 0 1/2 0 0; 0 0 1/2 1/2; 0 1/2 0 1/2];
% P5 = [1 0 0 0; 0 1/2 1/2 0; 0 0 1/2 1/2; 0 1/2 0 1/2]; (Do not use this
% combination)

% Didnot work (Error while takinginverse due to Singular matrices)
% P1 = [1/3 0 0 0 0; 1/3 1/3 0 0 0; 1/3 1/3 1 0 0; 0 0 0 1 0; 0 1/3 0 0 1];
% P2 = [1 0 0 0 0; 0 1 0 0 0; 0 0 1/2 0 1/2; 0 0 0 1 0; 0 0 1/2 0 1/2];
% P3 = [1 0 0 1/2 0; 0 1 0 0 0; 0 0 1 0 0; 0 0 0 1/2 0; 0 0 0 0 1];

P1 = [1/3 0 0 0 0; 1/3 1/2 0 0 0; 1/3 1/2 1 0 0; 0 0 0 1 0; 0 0 0 0 1];
P2 = [1 0 0 1/2 0; 0 1/2 0 0 0; 0 0 1 0 0; 0 0 0 1/2 1/2; 0 1/2 0 0 1/2];
P3 = [1 0 0 0 0; 0 1 0 0 0; 0 0 1/2 0 1/2; 0 0 0 1 0; 0 0 1/2 0 1/2];

P_stacked(:,:,1) = P1; 
P_stacked(:,:,2) = P2; 
P_stacked(:,:,3) = P3; 
% P_stacked(:,:,4) = P4; 

P_timeVariant = P_stacked;
dim_P_stacked = size(P_stacked);
no_of_graphs = dim_P_stacked(3);

% 
% while(~isempty(temp))
%     len_temp = size(temp);    
%     if (length(len_temp) == 3) % three dimensional array
%         rand_index = randi([1 len_temp(3)]);
%         P_timeVariant = temp(:,:,rand_index);
%         temp(:,:,rand_index) = [];
%     elseif (length(len_temp) == 2) % for the last matrix
%         P_timeVariant = temp;
%         temp = [];
%     end
%     P_arxiv(:,:,i) = P_timeVariant;
%     i = i+1;
end