% script to calculate the velocity values (new time step)

function [U, V] = calc_UV(F, G, P, imax, jmax, delt, delx, dely)

% input variables
% -------------------------------------------------------------------------
% F & G     F and G terms from the simplified Navier Stokes equation
% P         Pressure
% imax      max. number of cells in x dir.
% jmax      max. number of cells in y dir.
% delt      time step
% delx      cell size in x dir.
% dely      cell size in y dir.

% output variables
% -------------------------------------------------------------------------
% U         velocity in x dir.
% V         velocity in y dir.


U = zeros(jmax+2, imax+2);
V = zeros(jmax+2, imax+2);

for j=2:jmax+1
    for i=2:imax+1
        U(j, i) = F(j, i) - ((delt / delx) * (P(j, i+1) - P(j, i)));
        V(j, i) = G(j, i) - ((delt / dely) * (P(j+1, i) - P(j, i)));
    end
end

end


