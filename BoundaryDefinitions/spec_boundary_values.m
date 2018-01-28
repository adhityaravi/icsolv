% script to specify inflow conditions and the internal boundaries dependent
%  on the respective problem

function [U, V] = spec_boundary_values(U, V, imax, jmax, problem)

% input variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity
% imax            max. cells in x direction
% jmax            max. cells in y direction
% problem         problem name that defines the type of boundary conditions

% output variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity


switch problem
    
    case 'the_driven_cavity'
        [U, V] = set_TheDrivenCavity(U, V, jmax, imax);
        
    case 'the_von_karmann'
        [U, V] = set_TheVonKarmann(U, V, jmax, imax);
        
    case 'flow_above_stair'
        [U, V] = set_FlowAboveStair(U, V, jmax, imax);
        
    case 'schraegem_balken'
        [U, V] = set_SchraegemBalken(U, V, jmax, imax);
        
    case 'cylinder_wake'
        [U, V] = set_CylinderWake(U, V, jmax, imax);
        
    otherwise
        error('Not implemented yet');
        
end

end