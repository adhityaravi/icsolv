% script to visualize the results using the visual.m script

function plot_results(varargin)

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
    
elseif nargin == 8
    
    U = varargin{1};
    V = varargin{2};
    Psi = varargin{3};
    Zeta = varargin{4};
    jmax = varargin{5};
    imax = varargin{6};
    delx = varargin{7};
    dely = varargin{8};
    
    subplot(1, 2, 1)
    visual(U, V, jmax, imax, delx, dely, 'quiver');
    hold on
    visual(Psi, 'contour');
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

    subplot(1, 2, 2)
    visual(U, V, jmax, imax, 'quiver');
    hold on
    visual(Zeta, 'contour');
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
    
else   
    error('Check Input');
    
end