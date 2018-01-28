% script to interpolate u and v velocities at the given (x, y) location

function [u, v] = interpolation(U, V, imax, jmax, delx, dely, x, y)

% input variables
% -------------------------------------------------------------------------
% U       - U velocity of the entire domain
% V       - V velocity of the entire domain
% imax    - max. number of cells in x dir.
% jmax    - max. number of cells in y dir.
% delx    - cell size in x dir.
% dely    - cell size in y dir.
% x, y    - position where the velocity value is required

% output variables
% -------------------------------------------------------------------------
% u       - u velocity at the given location
% v       - v velocity at the given location

%% u velocity interpolation

% finding the ucell where the (x, y) is located
i = fix(x/delx) + 1;
j = fix((y+(dely/2))/dely) +1;

% finding the vertices of the located ucell
x1 = (i-1) * delx;
x2 = i * delx;
y1 = ((j-1)-(1/2)) * dely;
y2 = (j-(1/2)) * dely;

% finding the u velocity at every node of the current ucell
u1 = U(j-1, i-1);
u2 = U(j-1, i);
u3 = U(j, i-1);
u4 = U(j, i);

% bilinear interpolation
u = (1/(delx*dely)) * (((x2-x)*(y2-y)*u1) + ((x-x1)*(y2-y)*u2) + ...
                       ((x2-x)*(y-y1)*u3) + ((x-x1)*(y-y1)*u4));

%% v velocity interpolation

% finding the vcell where the (x, y) is located
i = fix((x+(delx/2))/delx) + 1;
j = fix(y/dely) + 1;

% finding the vertices of the located vcell
x1 = ((i-1)-(1/2)) * delx;
x2 = (i-(1/2)) * delx;
y1 = (j-1) * dely;
y2 = j * dely;

% finding the v velocity at every node of the current vcell
v1 = V(j-1, i-1);
v2 = V(j-1, i);
v3 = V(j, i-1);
v4 = V(j, i);

% bilinear interpolation
v = (1/(delx*dely)) * (((x2-x)*(y2-y)*v1) + ((x-x1)*(y2-y)*v2) + ...
                       ((x2-x)*(y-y1)*v3) + ((x-x1)*(y-y1)*v4));
                
end



