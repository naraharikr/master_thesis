function [P_aug] = aug_weight_matrix(P,maxDelay)
% ============================================
%
%
% Function to create the augmented graph
%
%
% ============================================
n=length(P);
% Identity and zero matrices
I=eye(n,n);
O=zeros(n,n);

% generate the random states for all the different delays
R=maxDelay*rand(size(P));
P0=P; 
P0(find(P))=1; 
P0=P0-diag(diag(P0));
R=R.*P0;
R=round(R);

% generate the tables
P_i = zeros(maxDelay+1, n, n);

for i=1:n
    for j=1:n
        % loop for each possible delay
        for d=1:maxDelay+1
            % check if we matched our delay
            if R(i, j) == d-1
                % assign the value to to the state based on P
                P_i(d, i, j) = P(i, j);
                continue
            end
        end
    end
end

% construct column/row-stochastic augmented matrix
column_sum = sum(P,1)';
row_sum = sum(P,2);
if all(column_sum == 1)
    P_aug = gen_cs_aug_matrix(P_i,I,O,maxDelay);
elseif all(row_sum == 1)
    P_aug = gen_rs_aug_matrix(P_i,I,O,maxDelay);
end