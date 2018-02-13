% script to preform Restriction operation for Multigrid method

function [ResX] = restrict(X)

% input variables
% -------------------------------------------------------------------------
% X        - Variable to restricted

% output variables
% -------------------------------------------------------------------------
% ResX     - Restricted variable

[jmax, imax] = size(X);
ResX = zeros(jmax/2, imax/2);

% initializing counter
ctriX = 0;
ctrjX = 0;

% restriction operation
for j=1:(jmax/2)
    for i=1:(imax/2)
        jX = j + ctrjX;
        iX = i + ctriX;
        
        ResX(j, i) = (1/4) * (X(jX, iX) + X(jX+1, iX) +... 
                              X(jX, iX+1) + X(jX+1, iX+1));
                          
        ctriX = ctriX + 1;
    end
    ctrjX = ctrjX + 1;
    ctriX = 0;
end
