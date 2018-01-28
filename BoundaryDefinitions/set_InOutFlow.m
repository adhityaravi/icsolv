% script to set inflow / outflow boundary conditions

function [U, V] = set_InOutFlow(U, V, jmax, imax, loc)

% input variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity
% imax            max. cells in x direction
% jmax            max. cells in y direction
% loc             the boundary which requires inflow / outflow condition
% output variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity

switch loc
    
    % setting inflow/outflow conditions on right boundary
    case 'right'
        for j=2:jmax+1
            U(j, imax+1) = U(j, imax);
            V(j, imax+2) = V(j, imax+1);
        end
        
    % setting inflow/outflow conditions on left boundary    
    case 'left'
        for j=2:jmax+1
            U(j, 1) = U(j, 2);
            V(j, 1) = V(j, 2);
        end
    
    % setting inflow/outflow conditions on top boundary
    case 'top'
        for i=2:imax+1
            U(jmax+2, i) = U(jmax+1, i);
            V(jmax+1, i) = U(jmax, i);
        end
    
    % setting inflow/outflow conditions on bottom boundary
    case 'bottom'
        for i=2:imax+1
            U(1, i) = U(2, i);
            V(1, i) = V(2, i);
        end
        
    otherwise
        error('Check Input');
        
end

end
        
    
        
        
    