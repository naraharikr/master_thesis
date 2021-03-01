%% START
function gFeval=compute_gradient(z,x0,alpha)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the gradient of quadratic private cost function 
% at each node
%           fi(x) = 0.5*alpha*(x-x0)^2 
% 
% INPUT: z = gradinet evaluation point (RN)
%        x0 = demand in node (RN)
%        alpha = RN
%
% OUTPUT: gFeval = gradient of fi(x) at z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = length(x0);
x = sym('x',[1 n]);

f=0;
for j=1:n
    f=f+0.5*alpha*(x(j)-x0(j))^2;
end

gF = gradient(f,x);

gFeval = subs(gF,x,z);

%% END