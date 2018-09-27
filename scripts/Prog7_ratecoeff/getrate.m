m = 9.109e-31; % electron mass
kB = 1.380e-23;  % Boltzmann constant in m^2 kg s^-2 K^-1
TeV = 15; % temperature in eV
T = TeV*11604; % temperature in Kelvin

% loading the cross-section
sigdata = load('sigmaion.dat');
xsig = sigdata(:,1);
ysig = sigdata(:,2);

v = linspace(0,2e7,1e6); % sampling for speed
sigma = interp1(xsig, ysig, v, 'pchip', 0); % interpolating the cross-section

% Maxwell-Boltzmann distribution
Fv = 4*pi*v.^2.*(m/(2*pi*kB*T))^1.5.*exp(-m*v.^2/(2*kB*T)); % distribution function
kr_MB = trapz(v, v.*Fv.*sigma)
vmean = trapz(v, Fv.*v);

% Distribution function of a nearly monoenergetic beam
v0 = vmean;
width = vmean/100;
Fv2 = 1/(sqrt(2*pi)* width) * exp(-(v-v0).^2/(2*width^2)); % distribution function
kr_beam = trapz(v, v .* Fv2 .* sigma)

% Druyvesteyn
%Fv3_nnorm = v.^2 .* exp(-0.3240*(m*v.^2/(2*kB*T)).^2); % distribution function
%Fv3 = 1/(trapz(v,Fv3_nnorm)) .* Fv3_nnorm;
%kr_DD = trapz(v, v .* Fv3 .* ysig_resampled)

