%% START
function [cs_aug_mat] = gen_cs_aug_matrix(delayTable,I,O,maxDelay)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Function to contstruct column-stochastic augmented matrix
%
% Input: delayTable - generated delay tables for virtual nodes
%                 I - identity matrix
%                 O - zero matrix
%          maxDelay - maxdelay in the network
%
% Output: cs_aug_mat - column-stochastic augmented matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now construct the state matrix based on the above
aug = [];
% construct rows
for i=1:maxDelay+1
    % assign columns
    row = [];
    for j=1:maxDelay+1
        if j == 1
            row = [row squeeze(delayTable(i, :, :))];
        elseif j == i+1
            row = [row I];
        else
            row = [row O];
        end
    end
    % pad the row
    aug = [aug; row];
end
cs_aug_mat = aug;
%% END