% script to visualize the velocities and pressure

function visual(varargin)

% input variables
% -------------------------------------------------------------------------
% U              - u (x dir.) velocities
% V              - v (y dir.) velocities
% Psi            - stream function
% Zeta           - vorticity
% imax, jmax     - max. number of cells in x and y direction respectively
% P              - pressure

% creating a mesh plot for the final values of U, V, and P
if nargin == 6
    U = varargin{1};
    V = varargin{2};
    jmax = varargin{3};
    imax = varargin{4};
    P = varargin{5};
    
    if strcmp(varargin{6}, 'mesh')
        U_vis = zeros(jmax, imax);
        V_vis = zeros(jmax, imax);
        P_vis = zeros(jmax, imax);

        for i=2:imax+1
            for j=2:jmax+1
                U_vis((j-1), (i-1)) = U(j, i);
                V_vis((j-1), (i-1)) = V(j, i);
                P_vis((j-1), (i-1)) = P(j, i);
            end
        end

        figure
        title('Mesh plot of U velocity')
        mesh(U_vis);
        figure
        title('Mesh plot of V velocity')
        mesh(V_vis);
        figure
        title('Mesh plot of pressure')
        mesh(P_vis);
        
    else
        error('Check input')
        
    end

% creating a quiver plot to visualize the velocity field 
elseif nargin == 7
        
    if strcmp(varargin{7}, 'quiver')
        U = varargin{1};
        V = varargin{2};
        jmax = varargin{3};
        imax = varargin{4};
        delx = varargin{5};
        dely = varargin{6};
        
        U_vis = zeros(jmax, imax);
        V_vis = zeros(jmax, imax);

        for i=2:imax+1
            for j=2:jmax+1
                 U_vis((j-1), (i-1)) = U(j, i);
                 V_vis((j-1), (i-1)) = V(j, i);
            end
        end

        [x, y] = meshgrid(delx:delx:(imax*delx), dely:dely:jmax*dely);
        quiver(x, y, U_vis, V_vis, 1.5);
    
    else
        error('Check input');
        
    end

% creating a contour plot for vorticity or stream function
elseif nargin == 2
    
    if strcmp(varargin{2}, 'contour')
        Psi = varargin{1};
        
        contour(Psi);
    
    else
        error('Check input');
        
    end          
           
else
    error('Check input');
    
end

end



    
    
    
    