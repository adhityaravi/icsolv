% script to determine the position of the injected particles at the current
%  time step

function [part_x, part_y] = new_position(U, V, imax, jmax, delx, dely, ...
                                         delt, part_x, part_y)

% input variables
% -------------------------------------------------------------------------
% U        - U velocity over the entire domain
% V        - V velocity over the entire domain
% imax     - max. number of cells in x dir.
% jmax     - max. number of cells in y dir.
% delx     - size of the cell in x dir.
% dely     - size of the cell in y dir.
% part_x   - x position of the injected particle at the previous time step
% part_Y   - y position of the injected particle at the previous time step

% output variables
% -------------------------------------------------------------------------
% part_x   - x position of the injected particle at the current time step
% part_y   - y position of the injected particle at the current time step

for i=1:numel(part_x)
    [u, v] = interpolation(U, V, imax, jmax, delx, dely,...
                           part_x(i), part_y(i));
    part_x(i) = part_x(i) + (u*delt);
    part_y(i) = part_y(i) + (v*delt);
end