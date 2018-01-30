% script to solve imcompressible viscous Navier Stokes equation

% Implemented Problems
% -> The Driven Cavity - progpar('the_driven_cavity')
% -> The Von Karmann Vortex Street - progpar('the_von_karmann')
% -> Flow above a Stair - progpar('flow_above_stair')
% -> Wirbel Straße mit schrägem Balken - progpar('schraegem_balken')
% -> Cylinder Wake - progpar('cylinder_wake')

%% pre-processing
% clearing the workspace 
clc;
clear;

% adding the sub folders to the search path of matlab
fixPath();

% loading the program parameters
progpar('the_von_karmann');
load('inFile');

% setting all matlab warnings off
warning('off', 'all');

% fetching the obstacle coordinates
get_ObstacleCoords(problem, delx, dely, jmax, imax);

% inject particles for particle trace and streaklines
if strcmp(trace_streak, 'on')
    [pt_part_x, pt_part_y] = set_particles(N, ug, og, delx, 'pt');
end

% initializing the velocity and pressure throughout the grid
[U, V, P] = initgrid(imax, jmax, U_I, V_I, P_I, problem);

% initalizing time variable and frame variable (frames of the animation)
T = delt; 
i = 1;

%% time loop
while T <= T_end
    
    % setting the boundary values for the velocities
    [U, V] = boundary_values(U, V, imax, jmax, boundary_flags);
    
    % setting the problem specific boundary condtions
    [U, V] = spec_boundary_values(U, V, imax, jmax, problem);
    
    % calculating the F and G terms from the simplified NS equation
    [F, G] = calc_FG(U, V, imax, jmax, delt, delx, dely, GX, GY, alph, nu);
    
    % calculating the right hand side of the pressure equation
    RHS = calc_RHS(F, G, imax, jmax, delt, delx, dely);
    
    % calculating the pressure value at the current time step
    [P, it, res] = SOR(P, RHS, U, V, GX, GY, imax, jmax, delx, ...
                       dely, epsi, itermax, omg, nu);
    
    % calculating the velocity values at the current time step
    [U, V] = calc_UV(F, G, P, imax, jmax, delt, delx, dely);
    
    if strcmp(calc_psi_zeta, 'on') && strcmp(trace_streak, 'on')
        %calculating sizes of stream function and vorticity
        [Psi, Zeta] = psi_zeta(U, V, imax, jmax, delx, dely);
        
        % tracing the injected particles
        [pt_part_x, pt_part_y] = particletrace(U, V, imax, jmax, delx, ...
                                              dely, delt, pt_part_x,...
                                              pt_part_y);
        
        % ***Streaklines not yet implemented***
        sl_part_x = 0;
        sl_part_y = 0; 
        
        % plotting the results
        plot_results(U, V, Psi, Zeta, pt_part_x, pt_part_y, sl_part_x, ...
                     sl_part_y, jmax, imax, delx, dely);
        
    elseif strcmp(calc_psi_zeta, 'on') 
        %calculating sizes of stream function and vorticity
        [Psi, Zeta] = psi_zeta(U, V, imax, jmax, delx, dely);

        % creating a plot of velocity field, stream function and vorticity 
        plot_results(U, V, Psi, Zeta, jmax, imax, delx, dely);
        
    elseif strcmp(trace_streak, 'on')
        % tracing the injected particles
        [pt_part_x, pt_part_y] = particletrace(U, V, imax, jmax, delx, ...
                                              dely, delt, pt_part_x,...
                                              pt_part_y, problem);
                                          
        % ***Streaklines not yet implemented***
        sl_part_x = 0;
        sl_part_y = 0;
        
        % plotting the results
        plot_results(U, V, pt_part_x, pt_part_y, sl_part_x, sl_part_y,...
                     jmax, imax, delx, dely);
          
    else
        % creating a quiver plot of velocity field
        plot_results(U, V, jmax, imax, delx, dely);
        
    end
    
    % storing the frames to create an animation
    M(i) = getframe(gcf);
    
    % updating the time variable and frame variable
    T = T + delt;
    i = i+1;
    
end

%% post processing
% saving the temporal development of the fluid as an avi file
%movie2avi(M, 'Temporal development of the fluid'); %(not working)

% creating a mesh plot for the final values of U, V, and P
%visual(U, V, jmax, imax, P, 'mesh');

% deleting the input file and creating an output file 
%  with final U, V, P, and the animation
delete inFile.mat; 

if strcmp(calc_psi_zeta, 'on')
    save('outFile.mat', 'U', 'V', 'P', 'M', 'Psi', 'Zeta');
else
    save('outFile.mat', 'U', 'V', 'P', 'M');
end
   
% creating a cache for continue_simulation()
save('cache.mat');
