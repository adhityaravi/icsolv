% script to load the program parameters for the the selected problem

function progpar(problem)

% input variable
% -------------------------------------------------------------------------
% problem     the problem that has to be solved by Navier Stokes

switch problem
    
    case 'the_driven_cavity'
        progpar_TheDrivenCavity();
        
    case 'the_von_karmann'
        progpar_TheVonKarmann();
        
    case 'flow_above_stair'
        progpar_FlowAboveStair();
        
    case 'schraegem_balken'
        progpar_SchraegemBalken();
        
    case 'cylinder_wake'
        progpar_CylinderWake();
        
    otherwise
        error('Not implemented yet');
        
end

end
        