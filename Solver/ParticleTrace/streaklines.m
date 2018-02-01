% script to trace streaklines

function [sl_part_x, sl_part_y] = streaklines(U, V, imax, jmax, delx,...
                                              dely, delt, N, ug, og)
                                          
% input variables
% -------------------------------------------------------------------------
% U           - U velocity over the entire domain
% V           - V velocity over the entire domain
% imax        - max. number of cells in x dir.
% jmax        - max. number of cells in y dir.
% delx        - size of the cell in x dir.
% dely        - size of the cell in y dir.
% N           - Number of particles along y axis to be injected in the flow
% ug          - lower boundary
% og          - upper boundary

% output variables
% -------------------------------------------------------------------------
% sl_part_x   - x coordinates of the streaklines
% sl_part_y   - y coordinates of the streaklines

[part_x, part_y] = set_particles(N, ug, og, delx, imax, 'sl');

sl_part_x = zeros(N, 100000);
sl_part_y = zeros(N, 100000);

for i=1:N
    [part_x(:, i), part_y(:, i)] = new_position(U, V, imax, jmax, delx,...
                                                dely, delt, part_x(:, i),... 
                                                part_y(:, i)); 
             
    %sl_part_x(i, :) = part_x(i, :);
    %sl_part_y(i, :) = part_y(i, :);
    
end

% interpolating for better resolution

for i=1:N
    
    sl_part_x(i, :) = linspace(2*delx, imax*delx, 100000);
    spline_interpolant = spline(part_x(i, :), part_y(i, :));
    sl_part_y(i, :) = ppval(spline_interpolant, sl_part_x(i, :));
    
end




