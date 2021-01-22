%% START
% Compute the gradient of quadratic private cost function 
% f(y,alpha,rho) = 0.5*alpha(y-rho)^2 and return the result 
% w.r.t variable 'y'.
% 
%
% INPUT: f = cost function as symbolic function 
%        y = variable to be considered
%
% OUTPUT: df = gradient output
%
%% COMPUTE GRADIENT
function df = compute_gradient(f,y)
  %so we have an input symbolic function but for some reason
  %we are not in the context where the variables came from. 
  %it turns out to be as simple as
  df = gradient(f,y); 
  %or for greater certainty you could
  %g = gradient(f, symvar(f));  %which is what the simple call does
  %or perhaps you have a reason to do
  %syms x y z
  %g = gradient(f(x, y, z), [x y z])
  %for example it might be a symbolic function in three other
  %variables that you want to re-label as x, y, z.
end
%% END