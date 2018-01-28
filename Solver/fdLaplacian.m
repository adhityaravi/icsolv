% script to implement finite difference approximation of second order differentials

function sol = fdLaplacian(U, var, del, j, i)

% input variables
% -------------------------------------------------------------------------
% U             - u/v velocity
% var           - 'x'/'y'
% del           - cell size (delx/ dely)
% j/i           - cell id

% output variables
% -------------------------------------------------------------------------
% sol           - finite difference approximation of the differential

if var == 'x'
    sol = (U(j, i+1) - (2*U(j, i)) + U(j, i-1)) / (del^2);
elseif var == 'y'
    sol = (U(j+1, i) - (2*U(j, i)) + U(j-1, i)) / (del^2);
else
    error('Check input');
end

end
