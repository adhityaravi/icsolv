% script to solve the pressure equation using Multigrid method

% Cycle : FMV
% Smoothing : SOR

function [P, it, res] = FMV(P, RHS, h, epsi, itermax, omg, h1)

% input variables
% -------------------------------------------------------------------------
% P       - Initial Pressure value
% RHS     - right hand side of the pressure equation
% h       - size of the cell
% epsi    - precision criterion for smoothing operaation
% itermax - smoothing steps
% omg     - relaxation parameter for SOR (smoothing)
% h1      - relaxation parameter for the multigrid method

% output variables
% -------------------------------------------------------------------------
% P       - new Pressure value
% it      - iteration at which solution coverged
% res     - residue at which solution 

%% prep
[jmax, imax] = size(P);
jmax = jmax-2;
imax = imax-2;

%% pre-smoothing
[P] = SOR(P, RHS, 0, 0, 0, 0, imax, jmax, h, h, epsi, itermax, omg, 0);

%% Multigrid V cycle
if (h < h1) && (mod(jmax, 2) == 0) && (mod(imax, 2) == 0)
    
    % residue calculation
    rh = calcResidue(P, RHS);
    
    % restriction operation
    f2h = restrict(rh);
    
    % first recursive call to FMV
    u2h = FMV(zeros(size(f2h)), f2h, 2*h, epsi, itermax, omg, h1);
    
    % prolongation operation
    P = P + prolongate(u2h);
    
end

%% post-solving using V cycle
[P, it, res] = MV(P, RHS, h, epsi, itermax, omg, h1);

end