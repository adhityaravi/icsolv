% script to calculate the residue for multigrid methods

function [rh] = calcResidue(P, RHS)

% input variables
% -------------------------------------------------------------------------
% P       - solution for which the residue has to be calculated
% RHS     - right hand side

% output variables
% -------------------------------------------------------------------------
% rh      - residue

% system matrix build
[jmax, imax] = size(P);
jmax = jmax-2;
imax = imax-2;
A = buildSysmat(jmax, imax);

% converting P and RHS matrix to a vector with rows stacked one over the 
%  other
P = P';
RHS = RHS';
P = P(:);
RHS = RHS(:);

% residue calculation
rh = RHS - (A*P);

% reshaping residue into a matrix
rh = reshape(rh, imax+2, jmax+2);
rh = rh';

end

