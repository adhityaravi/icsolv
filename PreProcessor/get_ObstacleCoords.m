% script to fetch the obstacle coordinates 
%
% NOTE:
%     Currently the obstacle coordinates are found out in terms of cell
%     numbers(i, j) and then converted to the x and y coordinates of the 
%     actual domain. But, the better way is to find out the obstacle
%     coordinates in terms of x and y coordinates of the actual domain and 
%     then convert it to cell numbers (i, j). 

function get_ObstacleCoords(problem, delx, dely, jmax, imax)

% input variable
% -------------------------------------------------------------------------
% problem      problem which is to be solved by Navier Stokes

if exist('ObstacleCoordinates.mat', 'file')
    delete ObstacleCoordinates.mat
end

switch problem
    
    % no obstacle
    case 'the_driven_cavity' 
        if exist('ObstacleCoordinates.mat', 'file')
            delete ObstacleCoordinates.mat
        end
        
    % flow obstructed by a box    
    case {'flow_above_stair', 'the_von_karmann'}
        global corner
        global length
        global height
        
        corner(1) = corner(1)/delx;
        corner(2) = corner(2)/dely;
        
        length = round(length/delx);
        height = round(height/dely);
        
        x=1;
        
        for j=2:jmax+1
            for i=2:imax+1
                xdist = abs(corner(1)-i); % length of the beam
                ydist = abs(corner(2)-j); % height of the beam
                
                if xdist<=length && ydist<=height
                    icoord(x) = i;
                    jcoord(x) = j;
                    x = x+1;
                end
                
            end
        end
        
    % flow obstructed by a slanting beam    
    case 'schraegem_balken'
        
        a = 45; % angle at which the beam is tilted with x axis (fixed)
%--------------------------------------------------------------------------
% NOTE:
%     Changing the angle of tilt will not reflect in the solution. The    
%     angle is just used to determine the end coordinate of the beam. The
%     orientation of the beam is determined in the for loops below.
%     Changing the angle will only result in some undesired change in the 
%     length of the beam.
%--------------------------------------------------------------------------
        
        global start
        global length 
        
        start(1) = start(1)/delx;
        start(2) = start(2)/dely;
        
        length = round(length/delx);
        
        x1 = start(1);
        y1 = start(2);
        
        x2 = x1+round(length*cos(a));
        y2 = y1+round(length*sin(a));
        
        x=1;
        
        for j=2:jmax+1
            for i=2:imax+1
                
                if i==x1 && j==y1
                    icoord(x) = i;
                    jcoord(x) = j;
                    x = x+1;
                end
                if i>x1 && i<=x2 && j>y1 && j<=x2
                    icoord(x) = i;
                    jcoord(x) = j;
                    x1 = i;
                    y1 = j;
                    x = x+1;
                end
                
            end
        end
        
    % flow obstructed by a cylinder    
    case 'cylinder_wake'
        
        global center
        global radius
        
        if center(1)>(imax*delx) || center(2)>(jmax*dely)
            error('Center out of domain');
        end
        
        center(1) = (center(1)/delx);
        center(2) = (center(2)/dely);
        
        radius = radius/delx;

        x=1;

        for j=2:jmax+1
            for i=2:imax+1
                dist = sqrt(((center(1)-i)^2) + ((center(2)-j)^2));
                if dist <= radius
                    icoord(x) = i;
                    jcoord(x) = j;
                    x = x+1;
                end
            end
        end
        
    otherwise
        error('Not implemented yet');
        
end

if exist('icoord', 'var') && exist('jcoord', 'var')
    xcoord = (icoord-1) * delx;
    ycoord = (jcoord-1) * dely;
    save('ObstacleCoordinates.mat', 'icoord', 'jcoord', 'xcoord', 'ycoord');
end

%--------------------------------------------------------------------------
% NOTE:
%  icoord and jcoord represent the obstacle in terms of cell numbers. Since 
%  U and V velocity matrices correspond to the cell numbers and not the 
%  x and y coordinates of the actual domain. The xcoord and ycoord
%  represent the obstacle in terms of x and y coordinates of the actual
%  domain (which is necessary while plotting).
%--------------------------------------------------------------------------

end
        
        
        
        
   