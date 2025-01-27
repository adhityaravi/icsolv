% script to visualize the results using the visual.m script

function plot_results(varargin)

% plotting just the velocity field
if nargin == 6
    
    U = varargin{1};
    V = varargin{2};
    jmax = varargin{3};
    imax = varargin{4};
    delx = varargin{5};
    dely = varargin{6};
    
    visual(U, V, jmax, imax, delx, dely, 'quiver');
    hold on
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'R*');
    end
    hold off
    title('Velocity Field')
    xlabel('x ->')
    ylabel('y ->')
    legend('Velocity field', 'Obstacle')
    axis equal

% plotting velocity field, vorticity and stream function
elseif nargin == 8
    
    U = varargin{1};
    V = varargin{2};
    Psi = varargin{3};
    Zeta = varargin{4};
    jmax = varargin{5};
    imax = varargin{6};
    delx = varargin{7};
    dely = varargin{8};
    
    subplot(2, 1, 1)
    visual(U, V, jmax, imax, delx, dely, 'quiver');
    hold on
    visual(Psi, jmax, imax, delx, dely, 'contour');
    hold on
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'R*');
    end
    hold off
    axis equal
    title('Velocity field and Stream function')
    xlabel('x ->')
    ylabel('y ->')
    legend('Velocity field', 'Stream function', 'Obstacle')

    subplot(2, 1, 2)
    visual(U, V, jmax, imax, delx, dely, 'quiver');
    hold on
    visual(Zeta, jmax, imax, delx, dely, 'contour');
    hold on
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'R*');
    end
    hold off
    axis equal
    title('Velocity field and Vorticity')
    xlabel('x ->')
    ylabel('y ->')
    legend('Velocity field', 'Vorticity', 'Obstacle')

% plotting velocity field, particle trace and streak lines
elseif nargin == 10
    
    U = varargin{1};
    V = varargin{2};
    pt_part_x = varargin{3};
    pt_part_y = varargin{4};
    sl_part_x = varargin{5};
    sl_part_y = varargin{6};
    jmax = varargin{7};
    imax = varargin{8};
    delx = varargin{9};
    dely = varargin{10};
    
    subplot(2, 1, 1)
    visual(U, V, jmax, imax, delx, dely, 'quiver');
    hold on
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'R*');
    end
    hold off
    title('Velocity Field')
    xlabel('x ->')
    ylabel('y ->')
    legend('Velocity field', 'Obstacle')
    axis equal
    
    subplot(2, 1, 2)
    cla();
    hold on
    axis([0 (imax*delx)+(3*delx) 0 (jmax*dely)+(3*dely)])
    visual(pt_part_x, pt_part_y, 'pt')
    hold on
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'K*');
    end
    hold on
    [N, ~] = size(sl_part_x);
    for i=1:N
        visual(sl_part_x(i, :), sl_part_y(i, :), 'sl');
        hold on
    end
    hold off
    title('Particle trace and Streak lines')
    if exist('ObstacleCoordinates.mat', 'file')
        legend('Injected Particles', 'Obstacle', 'Streaklines')
    else
        legend('Injected Particles', 'Streaklines')
    end
    xlabel('x ->')
    ylabel('y ->')

% plotting velocity field, vorticity, stream function, particle trace and
%  streak lines
elseif nargin == 12
    U = varargin{1};
    V = varargin{2};
    Psi = varargin{3};
    Zeta = varargin{4};
    pt_part_x = varargin{5};
    pt_part_y = varargin{6};
    sl_part_x = varargin{7};
    sl_part_y = varargin{8};
    jmax = varargin{9};
    imax = varargin{10};
    delx = varargin{11};
    dely = varargin{12};
    
    subplot(3, 1, 1)
    visual(U, V, jmax, imax, delx, dely, 'quiver');
    hold on
    visual(Psi, jmax, imax, delx, dely, 'contour');
    hold on
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'R*');
    end
    hold off
    axis equal
    title('Velocity field and Stream function')
    xlabel('x ->')
    ylabel('y ->')
    legend('Velocity field', 'Stream function', 'Obstacle')

    subplot(3, 1, 2)
    visual(U, V, jmax, imax, delx, dely, 'quiver');
    hold on
    visual(Zeta, jmax, imax, delx, dely, 'contour');
    hold on
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'R*');
    end
    hold off
    axis equal
    title('Velocity field and Vorticity')
    xlabel('x ->')
    ylabel('y ->')
    legend('Velocity field', 'Vorticity', 'Obstacle')
    
    subplot(3, 1, 3)
    cla();
    hold on
    axis([0 (imax*delx)+(3*delx) 0 (jmax*dely)+(3*dely)])
    visual(pt_part_x, pt_part_y, 'pt')
    hold on
    [N, ~] = size(sl_part_x);
    for i=1:N
        visual(sl_part_x(i, :), sl_part_y(i, :), 'sl');
        hold on
    end
    if exist('ObstacleCoordinates.mat', 'file')
        load ObstacleCoordinates.mat
        plot(xcoord, ycoord, 'K*');
    end
    hold off
    title('Particle trace and Streak lines')
    xlabel('x ->')
    ylabel('y ->')
    legend('Injected Particles', 'Streaklines', 'Obstacle')
    
else   
    error('Check Input');
    
end