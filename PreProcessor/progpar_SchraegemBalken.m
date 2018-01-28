% script to set the program parameters for the Von Karmann vortex street 
%  problem

function progpar_SchraegemBalken()

% problem to solve
problem = 'schraegem_balken';

% max. cells in x direction
imax = 64;

% max. cells in y direction
jmax = 16;

% size of one cell in x direction
delx = 0.2;

% size of one cell in y direction
dely = 0.2;

% time step size
delt  = 0.02;

% End time
T_end = 1;

% maximum allowed iteration for pressure-iteration per time step(SOR)
itermax = 150;

% precision criterion for pressure-iteration(SOR)
epsi = 0.01;

% relaxation parameter for SOR iteration
omg = 1.7;

% discretisation parameter
alph = 0.9;

% viscosity
nu = 1.3414e-5;

% source terms
GX = zeros(jmax, imax);
GY = zeros(jmax, imax);

% initial values for u velocity, v velocity and pressure
U_I = ones(jmax, imax);
V_I = zeros(jmax, imax);
P_I = zeros(jmax, imax);

% flag for calculating psi and zeta
calc_psi_zeta = 'off';

% boundary flags
% -> 1 - Free Slip
% -> 2 - No Slip
% -> 3 - In Flow or Out Flow
boundary_flags.wl = 3;
boundary_flags.wr = 3;
boundary_flags.wt = 1;
boundary_flags.wb = 1;

% dimensions of the beam (beam is always tilted at 45 deg to the x axis)
global length
global start

start = [4, 1]; % left corner of the beam
length = 3; % length of the beam

% saving the values in a matlab input data file
save('inFile.mat', 'imax', 'jmax', 'delx', 'dely', 'delt', 'T_end', ...
     'itermax', 'epsi', 'omg', 'alph', 'nu', 'GX', 'GY', 'U_I', ...
     'V_I', 'P_I', 'calc_psi_zeta', 'boundary_flags','problem');


end