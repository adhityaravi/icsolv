% script for postprocessing (re-structuring P into a matrix) pressure

function P = postpSor(P, em, jmax, imax)

% input variables
% -------------------------------------------------------------------------
% P              - pressure (vector)
% em             - empty nodes
% jmax           - max. cells in y direction
% imax           - max. cells in x direction

% output variables
% -------------------------------------------------------------------------
% P             - re-structured pressure (matrix)

% adding zeros at the empty nodes
for i=1:numel(em)
    s = numel(P);
    P = [P(1:(em(i)-1));0;P(em(i):s)];
end

% reshaping P into a matrix
P = reshape(P, imax+2, jmax+2);
P = P';

end