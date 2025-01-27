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
        
        c(1) = (corner(1)/delx) + 1; 
        c(2) = (corner(2)/dely) + 1;
        
        l = round(length/delx);
        h = round(height/dely); 
        
        x=1;
        
        for j=(c(2)):jmax+1
            for i=(c(1)):imax+1
                xdist = abs(c(1)-i);% length of the beam
                ydist = abs(c(2)-j); % height of the beam
                
                if xdist<=l && ydist<=h
                    icoord(x) = i;
                    jcoord(x) = j;
                    x = x+1;
                end
                
            end
        end
        
    % flow obstructed by a slanting beam (beta)   
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
        
        s(1) = (start(1)/delx) + 1;
        s(2) = (start(2)/dely) + 1;
        
        l = round(length/delx);
        
        x1 = s(1);
        y1 = s(2);
        
        x2 = x1+round(l*cos(a));
        y2 = y1+round(l*sin(a));
        
        x=1;
        
        for j=2:jmax+1
            for i=2:imax+1
                
                if i==x1 && j==y1
                    icoord(x) = i;
                    jcoord(x) = j;
                    x = x+1;
                end
                if i>x1 && i<=x2 && j>y1 && j<=y2
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
        
        c(1) = (center(1)/delx) + 1;
        c(2) = (center(2)/dely) + 1;
        
        r = radius/delx;

        x=1;

        for j=2:jmax+1
            for i=2:imax+1
                dist = sqrt(((c(1)-i)^2) + ((c(2)-j)^2));
                if dist <= r
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
    icoord = round(icoord);
    jcoord = round(jcoord);
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
        
        
        
        
   