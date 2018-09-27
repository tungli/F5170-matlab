% This matlab script solves the equation of motion
% for a charged particle in Earth's magnetic field.

% To make the program run faster, we will define all our
% constants as global variables. Global variables are defined only
% at one place but can be accessed from every Matlab program and function
% running in the same workspace.
global Re; global m; global qe; global mu0; global M;
Re = 6378137;	 % Earth radius in meters
m = 1.627e-27;	 % Particle mass in kg
qe = 1.602e-19;	 % particle charge in Coulomb
esc = 1; 	 % Earth scale - how many times larger will the earth be plotted
c = 299792458;	 % Speed of light in m/s
mu0 = 4*pi*1e-7; % Vacuum permeability in V*s/(A*m)
M = 7.94e22;	 % Earth's magnetic moment in H/m, in SI: V*s/(A*m)

% Initial conditions for position
% Defined in spherical coordinates for convenience ...
r0 = 3*Re;
phi0 = 0;
theta0 = pi/2;
% ... and transformed to cartesian.
x0 = r0*sin(theta0)*cos(phi0)
y0 = r0*sin(theta0)*sin(phi0)
z0 = r0*cos(theta0)

% Initial conditions for velocity
% defined using particle energy and two angles
Ek_eV = 5e7;			% energy in eV
Ek = Ek_eV*1.602e-19;		% energy in Joule
v_r0 = c*(1+m*c^2/Ek)^-0.5	% velocity magnitude - relativistic
v_phi0 = 0;			% azimuthal angle in rad
v_theta0 = pi/4;		% polar angle in rad

% Coordinate transform for velocity.
vx0 = v_r0*sin(v_theta0)*cos(v_phi0)
vy0 = v_r0*sin(v_theta0)*sin(v_phi0)
vz0 = v_r0*cos(v_theta0)

% Defining the vector of initial conditions
q0 = [x0;y0;z0;vx0;vy0;vz0];

% Defining the time interval
ti = 0;		% initial time in seconds
tf = 20;	% final time in seconds
N = 10000;	% number of steps
timespan = linspace(ti,tf,N);

% Solving the ODE. 
% Please note that odefun(t,q) is different from Program 1
[t, q] = ode45(@odefun, timespan, q0);


% Having solved the equation, the data has to be plotted.
% It is not necessary to understand what each of the commands 
% below does.

h = figure; 	% We set create a new figure. We did not have to do this
% in Program 1 because we were plotting only one curve. When plotting more 
% curves into the same figure, you should create it explicitly.

% The following set of commands plots the magnetic lines of force.
% [Adapted from MagLForce script by  Abdulwahab Abokhodair (2005)]
n = 4;
d2r = pi/180; r2d=1/d2r;
tht=d2r*(0:5:360)';
phi=d2r*(0:ceil(180/n):180);
hh=phi*r2d;
A=r0;
r=A*sin(tht).^2;
rho=r.*sin(tht);
x=rho*cos(phi);
y=rho*sin(phi);
[nR,nC]=size(x);
u=ones(1,nC);
z=r.*cos(tht)*u;
plot3(x/Re,y/Re,z/Re,'r','LineWidth',1.0);

hold on; % This command is useful. It tells Matlab that whatever you are going
% to plot next will be a part of the same figure!!!

% The following commands plot an ellipsoid, representing the Earth.
[u,v,w]=sphere(30);
surf(esc*u, esc*v, esc*0.9*w);
colormap('default');
camlight right;
lighting phong;
axis equal % Useful!! This forces the axes to display with the same scale!

% Finally, we plot the particle trajectory and add labels to axes.
plot3(q(:,1)/Re, q(:,2)/Re, q(:,3)/Re,'LineWidth',1.0)
set(gca,'FontSize',18) % sets font size
xlabel('x [R_e]') % sets title of x-axis
ylabel('y [R_e]') % sets title of y-axis
zlabel('z [R_e]') % sets title of z-axis
title(['Proton trajectory, E = 50 MeV, t_i=', num2str(ti), ' s, t_f=', num2str(tf), ' s']) % sets figure title

print -dpng -r200 'ProtonMagField.png' % prints the figure to file
% using the png format with 200 dpi resolution.
