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
P0=P; P0(find(P))=1; P0=P0-diag(diag(P0));
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

% now construct the state matrix based on the above
P_aug = [];
% construct rows
for i=1:maxDelay+1
    % assign columns
    row = [];
    for j=1:maxDelay+1
        if j == 1
            row = [row squeeze(P_i(i, :, :))];
        elseif j == i+1
            row = [row I];
        else
            row = [row O];
        end
    end
    % pad the row
    P_aug = [P_aug; row];
end

