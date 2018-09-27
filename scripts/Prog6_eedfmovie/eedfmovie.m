m0 = 1.6605e-27; % a.m.u. in kilograms
m = 40*m0;    % particle mass in kilograms
kB = 1.380e-23;  % Boltzmann constant in m^2 kg s^-2 K^-1
Vm = 5e8;    % collision frequency, Hz
time = linspace(0, 1e-8, 100); % time interval
v = linspace(-2000,2000,200); % velocity interval

% initial distribution function, f_0
sigma = 10; % Initial width
v0 = 500; % initial velocity
fx_init = 1/(sqrt(2*pi)* sigma) * exp(-(v-v0).^2/(2*sigma^2));
fy_init = v*0;
fz_init = v*0;

% Calculating the equilibrium temperature, the following follows from
% energy conservation.
v_sq = sqrt(trapz(v, (fx_init+fy_init+fz_init).*v.^2));
Teq = 1/3*m*v_sq^2/kB;

% equilibrium distribution function
fx_eq = sqrt(m/(2*pi*kB*Teq)) * exp(-m*v.^2/(2*kB*Teq));
fy_eq = sqrt(m/(2*pi*kB*Teq)) * exp(-m*v.^2/(2*kB*Teq));
fz_eq = sqrt(m/(2*pi*kB*Teq)) * exp(-m*v.^2/(2*kB*Teq));

fx = fx_init;
fy = fy_init;
fz = fz_init;

hFig = figure; % creating the figure, setting dimensions
set(hFig, 'Position', [100 300 1000 300]); 
for j=1:length(time), % for loop making the time steps
    absmax = max([fx, fy, fz])*1.1; % ensures adaptive y-axis scale
    absmax = max([max(fx_init), max(fy_init), max(fz_init)]); % uncomment for fixed scale
    subplot(1,3,1); % first subplot - x
    plot(v, fx, 'b', 'LineWidth', 2);
    ylabel('f(v_x)');
    xlabel('v_x');
    ylim([0, absmax]);
    whitebg('white')
    subplot(1,3,2); % second subplot - y
    plot(v, fy, 'r', 'LineWidth', 2);
    ylabel('f(v_y)');
    xlabel('v_y');
    ylim([0, absmax])
    subplot(1,3,3); % third subplot - z
    plot(v, fz, 'm', 'LineWidth', 2);
    ylabel('f(v_z)');
    xlabel('v_z');
    ylim([0, absmax]);
    % setting figure title - time
    ax=axes('Units','Normal','Position',[.075 .075 .85 .85],'Visible','off');
    set(get(ax,'Title'),'Visible','on')
    title(['t = ', num2str(time(j)), ' s']);
    % calculating new values of fx, fy, fz
    fx = fx_eq + (fx_init - fx_eq)*exp(-time(j)*Vm);
    fy = fy_eq + (fy_init - fy_eq)*exp(-time(j)*Vm);
    fz = fz_eq + (fy_init - fz_eq)*exp(-time(j)*Vm);
    M(j) = getframe(gcf); % appends a frame to matlab structure M
end
movie2avi(M, 'out.avi', 'fps', 7); % saves an avi movie with 7 fps