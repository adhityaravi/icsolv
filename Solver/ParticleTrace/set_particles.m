% script to set N number of particles on the domain for tracing 

function [part_x, part_y] = set_particles(N, ug, og, delx, imax, type)

% input variables
% -------------------------------------------------------------------------
% N        - Number of particles along y axis to be injected in the flow
% ug       - lower boundary
% og       - upper boundary
% delx     - cell size in x direction
% imax     - max. number of cells in x direction
% type     - particle trace or streak lines ('pt' or 'sl')

% output variables
% -------------------------------------------------------------------------
% part_x   - x coordinate of the particle
% part_y   - y coordinate of the particle

if strcmp(type, 'pt')
    part_y = linspace(ug, og, N);
    part_x = 2*delx*ones(1, N);
    
elseif strcmp(type, 'sl')
    part_y = zeros(N, N);
    part_x = zeros(N, N);
    N_slpts = linspace(2*delx, imax*delx, N);
    
    for i=1:N
        part_y(:, i) = linspace(ug, og, N);
        part_x(:, i) = N_slpts(i) * ones(1, N);
    end
    
else
    error('Check Input');
    
end

end