% script to calculate F and G terms 

function [F, G] = calc_FG(U, V, imax, jmax, delt, delx, dely, GX, GY, ...
                          alpha, nu)

% input variables
% -------------------------------------------------------------------------
% U             - u velocity
% V             - v velocity
% imax          - max. cells in x direction
% jmax          - max. cells in y direction
% delt          - time step
% delx          - cell size in x direction
% dely          - cell size in y direction
% GX            - source term in x direction
% GY            - source term in y direction
% alpha         - parameter for balancing between first and second order 
%                 approximations
% nu            - viscosity

% output variables
% -------------------------------------------------------------------------
% F and G terms from the simplified Navier Stokes equation

F = zeros(jmax+2, imax+2);
G = zeros(jmax+2, imax+2);

% interior values of F and G
for j=2:jmax+1  
    for i=2:imax+1 
        F(j, i) = U(j, i) + (delt * ((nu * (fdLaplacian(U, 'x', ...
                  delx, j, i) + fdLaplacian(U, 'y', dely, j, i))) - ...
                  fdGradient(U, 2, 'x', delx, alpha, j, i) - fdGradient...
                  (U, V, 'y', dely, alpha, j, i) + GX(j-1, i-1)));
    end
end

for j=2:jmax+1
    for i=2:imax+1
        G(j, i) = V(j, i) + (delt * ((nu * (fdLaplacian(V, 'x', ...
                  delx, j, i) + fdLaplacian(V, 'y', dely, j, i))) - ...
                  fdGradient(V, 2, 'y', dely, alpha, j, i) - fdGradient...
                  (U, V, 'x', delx, alpha, j, i) + GY(j-1, i-1)));
    end
end

% boundary values of F and G
for j=2:jmax+1
    F(j, 1) = U(j, 1);
    F(j, imax+1) = U(j, imax+1);
end

for i=2:imax+1
    G(1, i) = V(1, i);
    G(jmax+1, i) = V(jmax+1, i);
end

end