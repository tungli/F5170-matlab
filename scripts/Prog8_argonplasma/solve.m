% setting global variables
global p;
global kB;
global Tg;
global Te;
p = 1e6;        % pressure in Pa 
kB = 1.38e-23;  % Boltzmann constant in m^2 kg s^-2 K^-1
Tg = 400;       % Gas temperature in Kelvin
Te = 2;         % Electron temperature in eV

tsteps = 5000; % number of time steps
tspan = logspace(-11, -6, tsteps); % this time, we do not use linear spacing for the time but rather logalithmic
% Initial number densities in m^-3
nArs_init = 1e12; % Ar*
nArp_init = 1e12; % Ar+
nAr2p_init = 1e12; % Ar_2+ 
ne_init = nArp_init+nAr2p_init; % electrons, follows from global neutrality
% The vector of initial densities
initial = [nArs_init, nArp_init, nAr2p_init, ne_init];

% Solving the system of ODEs
[t, sol] = ode45('odefun', tspan, initial);

% Plotting the data
close all
figure;
hold on;
nAr = p./(kB*Tg)-sol(:,2)-0.5*sol(:,3)-sol(:,1);
plot(log10(t), log10(nAr), 'c');
plot(log10(t), log10(sol(:,1)), 'r');
plot(log10(t), log10(sol(:,2)), 'b');
plot(log10(t), log10(sol(:,3)), 'm');
plot(log10(t), log10(sol(:,4)), 'k');
ylim([12, 26])
legend('Ar', 'Ar^*', 'Ar^+', 'Ar_2^+', 'electrons', 'Location', 'northwest')

xlabel('Time, log_{10} [s]');
ylabel('Number density, log_{10} [m^{-3}]');
title(['p=', num2str(p), ' Pa, T_g=', num2str(Tg), ' K, T_e=', num2str(Te), 'eV']);
set(gca,'fontsize', 16);