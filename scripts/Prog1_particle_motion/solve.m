% This matlab script solves the equation of motion
% for a charged particle in presence of electric
% and magnetic fields.

% First, we need to define the initial conditions.
% Remember, q = [x,y,z,v_x,v_y,v_z]
q0 = [0;0;0;1e2;0;0];

% Now we define the time interval, on which
% we want to solve the ODE.
ti = 0;
tf = 2.5e-3;
N = 1000;
timespan = linspace(ti,tf,N);
% The function linspace(ti, tf, N) defines 
% a linearly spaced vector beginning at "ti"
% ending at "tf" with "N" steps/components.

% And now for the solving itself
% The notation @odefun tells the program
% that the first argument is a function.
[t, q] = ode45(@odefun, timespan, q0);

mesh([q(:,1) q(:,1)], [q(:,2) q(:,2)], [q(:,3) q(:,3)], [t(:) t(:)],'EdgeColor', 'interp', 'FaceColor', 'none');
view(2)
set(gca,'FontSize',18) % sets font size
xlabel('x [m]') % sets title of x-axis
ylabel('y [m]') % sets title of y-axis
zlabel('z [m]') % sets title of z-axis
title(['Particle trajectory, ti=', num2str(ti), ' s, tf=', num2str(tf), ' s']) % sets figure title

print -depsc 'Output.eps' % prints the figure to file
