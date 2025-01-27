% script to inject and trace particles

function [pt_part_x, pt_part_y] = particletrace(U, V, imax, jmax, delx,... 
                                                dely, delt, pt_part_x,...
                                                pt_part_y, problem)
                                      
% input variables
% -------------------------------------------------------------------------
% U           - U velocity over the entire domain
% V           - V velocity over the entire domain
% imax        - max. number of cells in x dir.
% jmax        - max. number of cells in y dir.
% delx        - size of the cell in x dir.
% dely        - size of the cell in y dir.
% pt_part_x   - x coordinate of the particle at the previous time step
% pt_part_y   - y coordinate of the particle at the previous time step
% problem     - prblem that is currently being solved 


% output variables
% -------------------------------------------------------------------------
% pt_part_x   - x coordinate of the particle at the current time step
% pt_part_y   - y coordinate of the particle at the current time step

% finding the new position of the particle
[pt_part_x, pt_part_y] = new_position(U, V, imax, jmax, delx, dely, delt,...
                                      pt_part_x, pt_part_y);
              
% finding and removing particles that strike an obstacle or go out of 
%  the domain

% particles striking an obstacle
if exist('ObstacleCoordinates.mat', 'file')
    load ObstacleCoordinates.mat;
    
    switch problem
        
        % box and slanting beam obstacles
        case {'the_von_karmann', 'flow_above_stair', 'schraegem_balken'}
            kx_min = find(pt_part_x > min(xcoord));
            kx_max = find(pt_part_x < max(xcoord));
            kx = intersect(kx_min, kx_max);
            
            ky_min = find(pt_part_y(kx) > min(ycoord));
            ky_max = find(pt_part_y(kx) < max(ycoord));
            ky = intersect(ky_min, ky_max);
            
            el = kx(ky);
            
            pt_part_x(el) = [];
            pt_part_y(el) = [];
            
        % circular obstacles
        case 'cylinder_wake'
            global radius
            
            for i=1:numel(pt_part_x)
                
                if sqrt((pt_part_x^2) + (pt_part_y^2)) <= radius
                    pt_part_x(i) = [];
                    pt_part_y(i) = [];
                end
                
            end
            
        otherwise 
            error('Not implemented yet');
            
    end
    
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