%% START
function [select_matrix, updated_index] = ...
                                  select_timevariant_weight_matrix(P,index)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Randomly select a timevariant graph from the generated weight matrices
% such that no two matrices are repeated in a row successively.
% 
% INPUT: P = 3D-array of generated weight matrices (N x N x M)
%        index = number of graphs as array
%
% OUTPUT: select_matrix = randomly selected graph from P
%         updated_index = index of selected matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    updated_index = index;
    % select randomly one index
    id_rand=randperm(length(index),1);
    % select matrix at id_rand from P
    select_matrix = P(:,:,id_rand);
    % remove the matrix from P to avoid repetation
    updated_index(id_rand) = [];
end
%% END