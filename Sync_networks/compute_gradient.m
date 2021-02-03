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
  
% if(nargain<2)
%     break;
% else 
  df = gradient(f,y); 
  %for greater certainty you could
  %g = gradient(f, symvar(f));  %which is what the simple call does
% end %%END IF(NARGAIN<2)

end
%% END