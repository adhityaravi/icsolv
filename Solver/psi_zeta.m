% script to calculate stream function and vorticity

function [Psi, Zeta] = psi_zeta(U, V, imax, jmax, delx, dely)

% input variables
% -------------------------------------------------------------------------
% U        velocity in x dir.
% V        velocity in y dir.
% imax     max. number of cells in x dir.
% jmax     max. number of cells in y dir.
% delx     cell size in x dir.
% dely     cell size in y dir.

% output variables
% -------------------------------------------------------------------------
% Psi      value of stream function 
% Zeta     value of vorticity

% initializing the stream function and vorticity
Psi = zeros(jmax, imax);
Zeta = zeros(jmax, imax);

% calculating the stream function 
for j=2:jmax
    Psi(j, :) = (dely * U(j+1, 2:imax+1)) + Psi(j-1, :);
end

% calculating the vorticity
for j=1:jmax
    for i=1:imax
        Zeta(j, i) = fdGradient(U, 'y', dely, j+1, i+1) - ...
                     fdGradient(V, 'x', delx, j+1, i+1);
    end
end
    