% script to inject and trace particles

function [pt_part_x, pt_part_y] = particletrace(U, V, imax, jmax, delx,... 
                                          dely, delt, pt_part_x, pt_part_y)
                                      
% input variables
% -------------------------------------------------------------------------
% U        - U velocity over the entire domain
% V        - V velocity over the entire domain
% imax     - max. number of cells in x dir.
% jmax     - max. number of cells in y dir.
% delx     - size of the cell in x dir.
% dely     - size of the cell in y dir.
% N        - Number of particles along y axis to be injected in the flow
% ug       - lower boundary
% og       - upper boundary
% delx     - cell size in x direction

% output variables
% -------------------------------------------------------------------------
% part_x   - x coordinate of the particle
% part_y   - y coordinate of the particle

[pt_part_x, pt_part_y] = new_position(U, V, imax, jmax, delx, dely, delt,...
                                      pt_part_x, pt_part_y);
              
% finding and removing particles that strikes an obstacle or goes out of 
%  the domain

% particles striking an obstacle
load ObstacleCoordinates.mat;

for i=1:numel(xcoord)
       el_i = pt_part_x == xcoord(i);
       el_j = pt_part_y == ycoord(i);
       pt_part_x(el_i) = [];
       pt_part_y(el_j) = [];
end

% particles travelling out of domain
el_l = pt_part_x < delx;
pt_part_x(el_l) = [];
pt_part_y(el_l) = [];
el_r = pt_part_x > (imax*delx);
pt_part_x(el_r) = [];
pt_part_y(el_r) = [];
el_t = pt_part_y < dely;
pt_part_x(el_t) = [];
pt_part_y(el_t) = [];
el_b = pt_part_y > (jmax*dely);
pt_part_x(el_b) = [];
pt_part_y(el_b) = [];

end