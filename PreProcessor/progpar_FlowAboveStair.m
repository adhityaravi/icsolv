% script to set the program parameters for the Flow above a stair problem 

function progpar_FlowAboveStair()

% problem to solve
problem = 'flow_above_stair';

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
T_end = 0.8;

% maximum allowed iteration for pressure-iteration per time step(SOR)
% NOTE : This acts as the number of Smoothing Steps for Multigrid
%        algorithms
itermax = 20;


% precision criterion for pressure-iteration(SOR)
epsi = 0.01;

% relaxation parameter for SOR iteration
omg = 1.7;

% discretisation parameter
alph = 0.12;

% viscosity
nu = 0.1;

% source terms
% setting source to zero
GX = zeros(jmax, imax);
GY = zeros(jmax, imax);

% initial values for u velocity, v velocity and pressure
% setting the initial values to 0
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
boundary_flags.wt = 2;
boundary_flags.wb = 2;

% dimensions of the stair
global corner
global length
global height

corner = [0, 0]; %lower left corner
length = 3;
height = 1.6;

% flag to plot particle trace and streak lines
trace_streak = 'off';

% parameters required to plot particle trace and streak lines
N = 10 ; % number of particles to be injected
ug = 0.4; % lower boundary from which particle injection starts
og = 3; % upper boundary where particle injection stops
delt_n = 2*delt; % time interval between which streak lines have to be
                 %  updated

% Solver options
% -> SOR - SOR method
% -> MV  - Multigrid V Cycle
% -> MW  - Multigrid W Cycle
% -> FMV - Full Multigrid V Cycle
Solver = 'FMV';
h1 = 1.2; % Mesh size limit for Multigrid methods

% saving the values in a matlab input data file
save('inFile.mat', 'imax', 'jmax', 'delx', 'dely', 'delt', 'T_end', ...
     'itermax', 'epsi', 'omg', 'alph', 'nu', 'GX', 'GY', 'U_I', ...
     'V_I', 'P_I', 'calc_psi_zeta', 'boundary_flags','trace_streak',...
     'N', 'ug', 'og', 'delt_n', 'Solver', 'h1', 'problem');


end