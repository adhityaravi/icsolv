% script to perform Prolongation operation for Multigrid method

function [ProX] = prolongate(X)

% input variables
% -------------------------------------------------------------------------
% X          - Variable to be prolongated

% output variables
% -------------------------------------------------------------------------
% ProX       - Prolongated variable

[jmax, imax] = size(X);
ProX = zeros(jmax*2, imax*2);

% initializing counter
ctriX = 0;
ctrjX = 0;

% prolongaation operation
for j=1:jmax
    for i=1:imax
        jX = j + ctrjX;
        iX = i + ctriX;
        
        ProX(jX, iX) = X(j, i);
        ProX(jX+1, iX) = X(j, i);
        ProX(jX, iX+1) = X(j, i);
        ProX(jX+1, iX+1) = X(j, i);
        
        ctriX = ctriX + 1;
    end
    ctrjX = ctrjX + 1;
    ctriX = 0;
end