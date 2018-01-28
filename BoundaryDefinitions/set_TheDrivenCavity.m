% script to set the boundary conditions for the driven cavity problem

function [U, V] = set_TheDrivenCavity(U, V, jmax, imax)

% input variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity
% imax            max. cells in x direction
% jmax            max. cells in y direction

% output variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity

for i=2:imax+1
    U(jmax+2, i) = 2-U(jmax+1, i);
end