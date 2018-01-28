% script to implement preprocessing (re-structuring P and RHS into vectors) 
%  for SOR
 
function [A, P, RHS] = prepSor(A, P, RHS, em)

% input variables
% -------------------------------------------------------------------------
% A             - system matrix
% P             - initial pressure value (matrix)
% RHS           - right hand side of the pressure equation (matrix)
% em            - empty nodes in the mesh

% output variables
% -------------------------------------------------------------------------
% A, P, RHS     - formatted A, P (vector), and RHS (vector)

% converting P and RHS matrix to a vector with rows stacked one over the 
%  other
P = P';
RHS = RHS';
P = P(:);
RHS = RHS(:);

ctr = 0;

% removing zero equations from the system 
for i=1:numel(em)
    A(em(i)-ctr, :) = [];
    A(:, em(i)-ctr) = [];
    P(em(i)-ctr, :) = [];
    RHS(em(i)-ctr, :) = [];
    ctr = ctr+1;
end

end
    
