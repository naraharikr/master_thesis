%% START
% Compute the gradient of quadratic private cost function 
% at each node
%           fi(x) = 0.5*alpha*(x-x0)^2 
% 
% INPUT: z = gradinet evaluation point (RN)
%        x0 = demand in node (RN)
%        alpha = RN
%
% OUTPUT: gFeval = gradient of fi(x) at z
%
%% Gradient computation
% function df = compute_gradient(f,y)
%   
% if(nargain<2)
%     break;
% else 
%   df = gradient(f,y); 
%   for greater certainty you could
%   g = gradient(f, symvar(f));  %which is what the simple call does
% end %%END IF(NARGAIN<2)
% 
% end
function gFeval=compute_gradient(z,x0,alpha)
n = length(x0);
x = sym('x',[1 n]);

f=0;
for j=1:n
    f=f+0.5*alpha*(x(j)-x0(j))^2;
end

gF = gradient(f,x);

gFeval = subs(gF,x,z);
%% END


