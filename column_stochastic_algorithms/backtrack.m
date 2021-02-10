%% START 
function [alpha] = backtrack(alpha,Xk,dk,F,gamma,delta,rhok)
%% BACKTRACKING ARMIJO-TYPE
% 
% Search method along a coordinate axis in which the search should be conducted 
% in both directions of the axis. It should also take into account the fact that 
% one direction dk can be assigned such that alpha=0 represents a 
% local minimum point of the function g(alpha)=F(xk+alpha*dk), for which 
% may not be able to find positive or negative values ??of alpha 
% close to 0 for which g(alpha)<g(0). If you do not want to use any 
% derivative, numerical "finished" procedures must define can 
% discriminate the situation. The model presented is an outline 
% Backtracking Armijo-type, based on the condition of acceptability of 
% type "Parabolic". 
% function [alpha] = backtr(alpha_guess,Xk,dk,F,gamma,delta,rhok)
% INPUT:
%       NOTE: (*) indicates necessary input, the other variables are optional 
%       (*) alpha _guess - current steplength (1*1) [>0];
%       (*) Xk           - current iterate    (N*1);
%       (*) dk           - search direction   (N*1);
%           gamma        - constant provided by the user (1*1) [>0];
%           delta        - constant provided by the user (1*1) into the range [0,  1];
%           rhok         - constant provided by the user (1*1) into the range [0,  1];
%       (*) F            - function handle of the objective function (RN->R );
% OUTPUT:
%       alpha - value of alpha whether the condition holds (1*1);
% REVISION:
%       Ennio Condoleo - 21.15 13 Feb 2014 
% REFERENCE:
%       http://books.google.it/books?id=wXyLzZahvmsC&pg=PA123&lpg=PA123&dq=ottimizzazione+unidimensionale+senza+derivata&source=bl&ots=p5Be0KpbtX&sig=tLnygv0XZwzQYHoyPPfCZ2-e4C4&hl=it&sa=X&ei=CfL7UqfpFcXRhAfujYHIBA&ved=0CDQQ6AEwAQ#v=onepage&q=ottimizzazione%20unidimensionale%20senza%20derivata&f=false
if (nargin < 5)
    gamma = 1e-4;
    delta = 0.5;
    rhok  = 1e-8;
elseif (nargin < 6)
    delta = 0.5;
    rhok = 1e-8;
elseif (nargin < 7)
    rhok = 1e-8;
end

    % positive direction (+)alpha
    alpha = alpha;
    while (F(Xk+alpha.*dk)>F(Xk)-gamma*alpha^2*(norm(dk))^2) 
        if (alpha*norm(dk) < rhok)   
            alpha  = 0;              % <-- failure to search for a value of alpha nonzero
        else
            alpha = alpha*delta;     % <-- reduction of the steplength
        end
    end 
    alpha1 = alpha;
    F1     = F(Xk+alpha1.*dk)-(F(Xk)-gamma*alpha1^2*(norm(dk))^2);
    
    % negative direction (-)alpha
    alpha = alpha;
    while (F(Xk-alpha.*dk)>F(Xk)-gamma*alpha^2*(norm(dk))^2)  
        if (alpha*norm(dk) < rhok)
            alpha   = 0;              % <-- failure to search for a value of alpha nonzero
        else
            alpha = alpha*delta;      % <-- reduction of the steplength
        end
    end
    alpha2 = -alpha;
    F2     = F(Xk+alpha2.*dk)-(F(Xk)-gamma*alpha2^2*(norm(dk))^2);
    % choice of the value of alpha for which it is provided with sufficient reduction 
    if (F1<F2)           
        alpha = alpha1;
    else
        alpha = alpha2;
    end  
    
end

%% END