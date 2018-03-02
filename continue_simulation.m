% script to continue the simulation till a new end time step

function continue_simulation(T_new)

% input variable
% -------------------------------------------------------------------------
% T_new         - new end time


try
    fixPath();
    
    % loading cache data from the previous simulation
    load('cache.mat');

    % correcting the time data from the last run simulation
    T = T - delt;

    if T_new > T
        % fetching the last frame number from the animation
        i = numel(M) + 1;

        % setting new end time
        T_end = T_new;

        % time loop
        while T <= T_end

             % setting the boundary values for the velocities
            [U, V] = boundary_values(U, V, imax, jmax, boundary_flags);

            % setting the problem specific boundary condtions
            [U, V] = spec_boundary_values(U, V, imax, jmax, problem);

            % calculating the F and G terms from the simplified NS equation
            [F, G] = calc_FG(U, V, imax, jmax, delt, delx, dely, GX, GY, alph, nu);

            % calculating the right hand side of the pressure equation
            RHS = calc_RHS(F, G, imax, jmax, delt, delx, dely);
   
            % calculating pressure 
            [P, it, res] = calc_P(P, RHS, delx, epsi, itermax, omg, h1, imax, jmax, Solver);

            % calculating the velocity values at the current time step
            [U, V] = calc_UV(F, G, P, imax, jmax, delt, delx, dely);

            if strcmp(calc_psi_zeta, 'on') && strcmp(trace_streak, 'on')
                %calculating sizes of stream function and vorticity
                [Psi, Zeta] = psi_zeta(U, V, imax, jmax, delx, dely);
                % tracing the injected particles
                [pt_part_x, pt_part_y] = particletrace(U, V, imax, jmax, delx, ...
                                                      dely, delt, pt_part_x,...
                                                      pt_part_y);
                % tracing the streaklines
                if (i==1) || (rem(i, delt_n) == 0)
                    [sl_part_x, sl_part_y] = streaklines(U, V, imax, jmax, delx,...
                                                         dely, delt, N, ug, og);
                end    
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
                % tracing the streaklines
                if (i==1) || (rem(i, delt_n) == 0)
                    [sl_part_x, sl_part_y] = streaklines(U, V, imax, jmax, delx,...
                                                         dely, delt, N, ug, og);
                end  
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

        % saving the temporal development of the fluid as an avi file
        %movie2avi(M, 'Temporal development of the fluid');

        % creating a mesh plot for the final values of U, V, and P
        %visual(U, V, jmax, imax, P);

        %clearing the T_new for the next continue_simulation
        clear T_new;

        % updating cache and output file
        save('cache.mat');
        if strcmp(calc_psi_zeta, 'on')
            save('outFile.mat', 'U', 'V', 'P', 'M', 'Psi', 'Zeta');
        else
            save('outFile.mat', 'U', 'V', 'P', 'M');
        end

    else
        error(['The new end time value is smaller than or equal to the',...
               'previous run simulation']);

    end
    
catch ME
    if(strcmp(ME.identifier, 'MATLAB:load:couldNotReadFile'))
        msg = (['There is no previous simulation data to continue.',...
                '\n\t: To start a new simulation, use the ',...
                '''incompvis'' command.']);
        causeException = MException(['MATLAB:continue_simulation',...
                                     ':no_cache'], msg);
        ME = addCause(ME, causeException);
    end
    
    rethrow(ME);
    
end
        
end

