% script for implementing finite difference approximations for first order 
%  differentials

function sol = fdGradient(varargin)

% possible varargin inputs
% -------------------------------------------------------------------------
% for approximating pressure               | for approximating velocity
%  differentials                           |  differentials
% varargin{1}   -   P                      | varargin{1}   -   U/V
% varargin{2}   -   'x'/'y'                | varargin{2}   -   2/V
% varargin{3}   -   delx/dely              | varargin{3}   -   'x'/'y'
% varargin{4}   -   j                      | varargin{4}   -   delx/dely
% varargin{5}   -   i                      | varargin{5}   -   alpha
%                                          | varargin{6}   -   j
%                                          | varargin{7}   -   i
% -------------------------------------------------------------------------

% input variables
% -------------------------------------------------------------------------
% P             - Pressure
% U             - u velocity
% V             - v velocity
% 'x'/'y'       - differentiate w.r.t. x or y 
% delx/dely     - cell size
% alpha         - parameter for balancing between first and second order 
%                 approximations
% i/j           - cell id

% output variables
% -------------------------------------------------------------------------
% sol           - Finite difference approximation of the differential


if nargin == 5
    
    P = varargin{1};
    del = varargin{3};
    j = varargin{4};
    i = varargin{5};
    
    if varargin{2} == 'x'
        
        % dp/dx
        sol = (P(j, i+1) - P(j, i)) / del;
        
    elseif varargin{2} == 'y'
        
        % dp/dy
        sol = (P(j+1, i) - P(j, i)) / del;
        
    else
        error('Check input');
    end
    
elseif nargin == 7
    
    if isscalar(varargin{2})
        if (varargin{2} == 2) && (varargin{3} == 'x')
           
            U = varargin{1};
            del = varargin{4};
            alpha = varargin{5};
            j = varargin{6};
            i = varargin{7};
            
            % d(u^2)/dx
            sol = ((1/del) * ( (((U(j, i) + U(j, i+1))/2)^2) - ...
                  (((U(j, i-1) + U(j, i))/2)^2) )) + ((alpha/del) * ...
                  (((abs(U(j, i) + U(j, i+1))/2) * ((U(j,i) - ...
                  U(j, i+1))/2)) - ((abs(U(j, i-1) + U(j, i))/2) * ...
                  ((U(j, i-1) - U(j, i))/2))));
            
        elseif (varargin{2} == 2) && (varargin{3} == 'y')
            
            V = varargin{1};
            del = varargin{4};
            alpha = varargin{5};
            j = varargin{6};
            i = varargin{7};
            
            % d(v^2)/dy
            sol = ((1/del) * ( (((V(j, i) + V(j+1, i))/2)^2) - ...
                  (((V(j-1, i) + V(j, i))/2)^2) )) + ((alpha/del) * ...
                  (((abs(V(j, i) + V(j+1, i))/2) * ((V(j,i) - ...
                  V(j+1, i))/2)) - ((abs(V(j-1, i) + V(j, i))/2) * ...
                  ((V(j-1, i) - V(j, i))/2))));
            
        else
            error('Check input');
        end
        
    else
        if varargin{3} == 'x'
            
            U = varargin{1};
            V = varargin{2};
            del = varargin{4};
            alpha = varargin{5};
            j = varargin{6};
            i = varargin{7};
            
            % d(uv)/dx
            sol = ((1/del) * ((((U(j, i) + U(j+1, i))/2) * ...
                  ((V(j, i) + V(j, i+1))/2)) - (((U(j, i-1) + U(j+1, ...
                  i-1))/2) * ((V(j, i-1) + V(j, i))/2)))) + ((alpha/del)...
                  * (((abs(U(j, i) + U(j+1, i))/2) * ((V(j, i) - ...
                  V(j, i+1))/2)) - ((abs(U(j, i-1) + U(j+1, i-1))/2) * ...
                  ((V(j, i-1) - V(j, i))/2))));
            
        elseif varargin{3} == 'y'
            
            U = varargin{1};
            V = varargin{2};
            del = varargin{4};
            alpha = varargin{5};
            j = varargin{6};
            i = varargin{7};
            
            % d(uv)/dy
            sol = ((1/del) * ((((U(j, i) + U(j+1, i))/2) * ((V(j, i) + ...
                  V(j, i+1))/2)) - (((V(j-1, i) + V(j-1, i+1))/2) * ...
                  ((U(j-1, i) + U(j, i))/2)))) + ((alpha/del) * ...
                  (((abs(V(j, i) + V(j, i+1))/2) * ((U(j, i) - ...
                  U(j+1, i))/2)) - ((abs(V(j-1, i) + V(j-1, i+1))/2) * ...
                  ((U(j-1, i) - U(j, i))/2))));
            
        else
            error('Check input');
        end
    end
    
end
        
        
    
    
        