% script to calculate the right hand side of the pressure equation

function RHS = calc_RHS(F, G, imax, jmax, delt, delx, dely)

% input variables
% -------------------------------------------------------------------------
% F & G terms from the simplifies Navier stokes equation
% imax           - max. number of cells in x direction
% jmax           - max. number of cells in y direction
% delt           - time step
% delx           - cell size in x direction
% dely           - cell size in y direction

% output variables
% -------------------------------------------------------------------------
% RHS            - right hand side of the pressure equation

RHS = zeros(jmax+2, imax+2);

% calculating the right hand side values of the pressure equation
for j=2:jmax+1
    for i=2:imax+1
        RHS(j, i) = (1/delt) * (((F(j, i) - F(j, i-1))/delx) + ...
                    ((G(j, i) - G(j-1, i))/dely));
    end
end

end
    