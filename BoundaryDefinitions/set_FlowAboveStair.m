% script to set the boundary conditions for the Flow above a stair problem

function [U, V] = set_FlowAboveStair(U, V, jmax, imax)

% input variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity
% imax            max. cells in x direction
% jmax            max. cells in y direction

% output variables
% -------------------------------------------------------------------------
% U               u velocity
% V               v velocity

for j=(jmax/2)+2:jmax+1
    U(j, 1) = 1;
    V(j, 1) = -V(j, 2);
end

load ObstacleCoordinates.mat

for x=1:numel(icoord)
    U(jcoord(x), icoord(x)) = 0;
    V(jcoord(x), icoord(x)) = 0;
end

end
   