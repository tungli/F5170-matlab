m0 = 1.6605e-27; % a.m.u. in kilograms
m = 40*m0;    % particle mass in kilograms
kB = 1.380e-23;  % Boltzmann constant in m^2 kg s^-2 K^-1
T = 1000;	 % temperature in Kelvin

v = linspace(0,4000,500); % x data
Fv = 4*pi*v.^2 .* (m/(2*pi*kB*T))^1.5 .* exp(-m*v.^2/(2*kB*T)); % distribution function
plot(v, Fv);
hold on;

% numerical expressions
v_mean = ... % mean speed
v_sq_mean = ... % mean quadratic speed

% analytical expressions
v_mean_an = ... % mean speed
v_sq_mean_an = ... % mean quadratic speed
v_mp_an = ... % most probable speed

lineht = max(Fv)*1.1;	% line height, only for plotting
plot([v_mean, v_mean], [0, lineht], 'r'); 	% mean speed
plot([v_sq_mean, v_sq_mean], [0, lineht], 'g'); % mean quadratic speed
plot([v_mp_an, v_mp_an], [0, lineht], 'm');	% most probable speed
hold off
