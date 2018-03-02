% script to solve for Pressure

function [P, it, res] = calc_P(P, RHS, delx, epsi, itermax, omg, h1, imax, jmax, Solver)

% input variables
% -------------------------------------------------------------------------
% P       - Initial Pressure value
% RHS     - right hand side of the pressure equation
% h       - size of the cell
% epsi    - precision criterion for smoothing operaation
% itermax - smoothing steps
% omg     - relaxation parameter for SOR (smoothing)
% h1      - relaxation parameter for the multigrid method
% Solver  - Solver flag

% output variables
% -------------------------------------------------------------------------
% P       - new Pressure value (at the current time step
% it             - iteration at which solution coverged
% res            - residue at which solution converged

switch Solver
    
    case 'SOR'
        [P, it, res] = SOR(P, RHS, 0, 0, 0, 0, imax, jmax, delx, delx, epsi, itermax, omg, 0);
        
    case 'MV'
        [P, it, res] = MV(P, RHS, delx, epsi, itermax, omg, h1);
        
    case 'MW'
        [P, it, res] = MW(P, RHS, delx, epsi, itermax, omg, h1);
        
    case 'FMV'
        [P, it, res] = FMV(P, RHS, delx, epsi, itermax, omg, h1);
        
end

end