% script to solve the pressure equation using SOR

function [P, it, res] = SOR(P, RHS, U, V, GX, GY, imax, jmax, delx, ...
                            dely, epsi, itermax, omg, nu)

% input variables
% -------------------------------------------------------------------------
% P              - initial pressure value to start the SOR iteration 
%                  (pressure from prev. iteration)
% RHS            - right hand side of the pressure equation
% U              - u (x dir.) velocities
% V              - v (y dir.) velocities
% GX, GY         - source terms in x and y dir. respectively
% imax, jmax     - max. number of cells in x and y dir. respectively
% delx           - size of the cell in x dir.
% dely           - size of the cell in y dir.
% epsi           - precision criterion for SOR iteration
% itermax        - max. allowed iteration for SOR
% omg            - relaxation parameter
% nu             - viscosity

% output variables
% -------------------------------------------------------------------------
% P              - new pressure value
% it             - iteration at which solution coverged
% res            - residue at which solution converged

if delx == dely
    % building the system matrix for the Poisson equation
    A = buildSysmat(jmax, imax);
    
    % finding out the empty nodes in the mesh
    em = meshMap(jmax, imax);
    
    % calculating the RHS 
    RHS = (delx^2) * RHS;
    
    % pre-processing A, P, and RHS
    [A, P, RHS] = prepSor(A, P, RHS, em);
    
    % solving for P using SOR algorithm
    [P, it, res] = solveSOR(A, RHS, omg, P, epsi, itermax);
    
    % post-processing P 
    [P] = postpSor(P, RHS, em, jmax, imax);
    
else 
    error(['Script cannot run for cells that have different',...
           ' dimension in x and y direction :(']);
    
end
    
end