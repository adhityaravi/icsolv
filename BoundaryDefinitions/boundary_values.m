% script to assign boundary values to the velocity variables 

function [U, V] = boundary_values(U, V, imax, jmax, boundary_flags)

% input variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity
% imax            max. cells in x direction
% jmax            max. cells in y direction
% boundary_flags  flags for the type of bc to be set on each boundary

% output variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity

% setting left boundary
switch boundary_flags.wl
    
    case 1
        [U, V] = set_FreeSlip(U, V, jmax, imax, 'left');
      
    case 2
        [U, V] = set_NoSlip(U, V, jmax, imax, 'left');
        
    case 3
        [U, V] = set_InOutFlow(U, V, jmax, imax, 'left');
        
    otherwise
        error('Check Input');
        
end

%setting right boundary
switch boundary_flags.wr
    
    case 1
        [U, V] = set_FreeSlip(U, V, jmax, imax, 'right');
      
    case 2
        [U, V] = set_NoSlip(U, V, jmax, imax, 'right');
        
    case 3
        [U, V] = set_InOutFlow(U, V, jmax, imax, 'right');
        
    otherwise
        error('Check Input');
        
end

% setting top boundary
switch boundary_flags.wt
    
    case 1
        [U, V] = set_FreeSlip(U, V, jmax, imax, 'top');
      
    case 2
        [U, V] = set_NoSlip(U, V, jmax, imax, 'top');
        
    case 3
        [U, V] = set_InOutFlow(U, V, jmax, imax, 'top');
        
    otherwise
        error('Check Input');
        
end

% setting bottom boundary
switch boundary_flags.wb
    
    case 1
        [U, V] = set_FreeSlip(U, V, jmax, imax, 'bottom');
      
    case 2
        [U, V] = set_NoSlip(U, V, jmax, imax, 'bottom');
        
    case 3
        [U, V] = set_InOutFlow(U, V, jmax, imax, 'bottom');
        
    otherwise
        error('Check Input');
        
end
        
        

end

    


