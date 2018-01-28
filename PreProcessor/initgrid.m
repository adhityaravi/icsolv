% script to initialize the values of u velocity, v velocity and pressure

function [U, V, P] = initgrid(imax, jmax, U_I, V_I, P_I, problem)

% input variables
% -------------------------------------------------------------------------
% imax               max. cells in x direction
% jmax               max. cells in y direction
% U_I                initial u velocity
% V_I                initial v velocity
% P_I                initial pressure
% problem            problem which is to be solved by Navier Stokes

% output variables
% -------------------------------------------------------------------------
% U                  u velocity
% V                  v velocity
% P                  pressure


% assign the values U_I, V_I and P_I to U, V and P respectively 
U = zeros(jmax+2, imax+2);
V = zeros(jmax+2, imax+2);
P = zeros(jmax+2, imax+2);

% initial interior node values
for j=2:jmax+1
    for i=2:imax+1
        U(j, i) = U_I(j-1, i-1);
        V(j, i) = V_I(j-1, i-1);
        P(j, i) = P_I(j-1, i-1);
    end
end

% initial horizontal boundary node values for pressure
for j=1:jmax+2
    P(j, 1) = P(j, 2);
    P(j, imax+2) = P(j, imax+1);
end

% initial vertical boundary node values for pressure
for i=1:imax+2
    P(1, i) = P(2, i);
    P(jmax+2, i) = P(jmax+1, i);
end

% setting lower half of the domain x velocity to zero for Flow above a
%  stair problem
if strcmp(problem, 'flow_above_stair')
    U(1:(jmax/2)+1, :) = 0;
end         

end
  
    
    


