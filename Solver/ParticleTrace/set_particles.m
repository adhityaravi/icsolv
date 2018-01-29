% script to set N number of particles on the domain for tracing 

function [part_x, part_y] = set_particles(N, ug, og, delx, type)

% input variables
% -------------------------------------------------------------------------
% N        - Number of particles along y axis to be injected in the flow
% ug       - lower boundary
% og       - upper boundary
% delx     - cell size in x direction
% type     - particle trace or streak lines ('pt' or 'sl')

% output variables
% -------------------------------------------------------------------------
% part_x   - x coordinate of the particle
% part_y   - y coordinate of the particle

if strcmp(type, 'pt')
    part_y = linspace(ug, og, N);
    part_x = 2*delx*ones(1, N);
    
elseif strcmp(type, 'sl')
    error('Not implemented yet');
    
else
    error('Check Input');
    
end

end