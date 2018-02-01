% script to set the program parameters for the Driven Cavity problem

function progpar_TheDrivenCavity()

% problem to solve
problem = 'the_driven_cavity';

% max. cells in x direction
imax = 16;

% max. cells in y direction
jmax = 16;

% size of one cell in x direction
delx = 0.2;

% size of one cell in y direction
dely = 0.2;

% time step size
delt  = 0.02;

% End time
T_end = 20;

% maximum allowed iteration for pressure-iteration per time step(SOR)
itermax = 150;

% precision criterion for pressure-iteration(SOR)
epsi = 0.01;

% relaxation parameter for SOR iteration
omg = 1.7;

% discretisation parameter
alph = 0.12;

% viscosity
nu = 0.4;

% source terms
GX = zeros(jmax, imax);
GY = zeros(jmax, imax);

% initial values for u velocity, v velocity and pressure
U_I = zeros(jmax, imax);
V_I = zeros(jmax, imax);
P_I = zeros(jmax, imax);

% flag for calculating psi and zeta
calc_psi_zeta = 'off';

% boundary flags
% -> 1 - Free Slip
% -> 2 - No Slip
% -> 3 - In Flow or Out Flow
boundary_flags.wl = 2;
boundary_flags.wr = 2;
boundary_flags.wt = 2;
boundary_flags.wb = 2;

% flag to plot particle trace and streak lines
trace_streak = 'on';

% parameters required to plot particle trace and streak lines
N = 10 ; % number of particles to be injected
ug = 0.4; % lower boundary from which particle injection starts
og = 3; % upper boundary where particle injection stops
delt_n = 2*delt; % time interval between which streak lines have to be
                 %  updated

% saving the values in a matlab input data file
save('inFile.mat', 'imax', 'jmax', 'delx', 'dely', 'delt', 'T_end', ...
     'itermax', 'epsi', 'omg', 'alph', 'nu', 'GX', 'GY', 'U_I', ...
     'V_I', 'P_I', 'calc_psi_zeta', 'boundary_flags','trace_streak',...
     'N', 'ug', 'og', 'delt_n', 'problem');


end

