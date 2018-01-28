% script to set no slip boundary conditions

function [U, V] = set_NoSlip(U, V, jmax, imax, loc)

% input variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity
% imax            max. cells in x direction
% jmax            max. cells in y direction
% loc             the boundary which requires no slip

% output variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity

switch loc
    
    % setting no slip on right boundary
    case 'right'
        for j=2:jmax+1
            U(j, imax+1) = 0;
            V(j, imax+2) = -V(j, imax+1);
        end
    
    % setting no slip on left boundary
    case 'left'
        for j=2:jmax+1
            U(j, 1) = 0;
            V(j, 1) = -V(j, 2);
        end
    
    % setting no slip on top boundary
    case 'top'
        for i=2:imax+1
            U(jmax+2, i) = -U(jmax+1, i);
            V(jmax+1, i) = 0;
        end
        
    % setting no slip on bottom boundary    
    case 'bottom'
        for i=2:imax+1
            U(1, i) = -U(2, i);
            V(1, i) = 0;
        end
        
    otherwise
        error('Check Input');
        
end

