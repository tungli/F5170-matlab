function dqdt = odefun(t,q),
	% This is the input function for the 
	% ordinary differential equation solver ode45.
	% Input: independent variable t(time), 6-dim vector q
	% q = [x,y,z,v_x,v_y,v_z]
	% Output: time derivative of q, dqdt = dq/dt

	qe = -1.602e-19;	% Elementary charge in Coulomb
	m = 9.109e-31;	% Particle mass in kg
	%m = 1.627e-27;
	% Now, we define position and velocity variables 
	% using the vector of dependent variables, q.
	% This would not be necessary but using 
	% "x" instead of q(1), etc.. makes the code 
	% below more readable
	x = q(1);	
	y = q(2);
	z = q(3);
	vx = q(4);
	vy = q(5);
	vz = q(6);
	
	Ex = 0;
	Ey = 2e-6;
	Ez = 0;
	Bx = 0;
	By = 0;
	Bz = 1e-7;

	% Now, we calculate the components of the 6-dim
	% vector dq/dt.
	dxdt = vx;	% dx/dt = v_x
	dydt = vy;	% dy/dt = v_y
	dzdt = vz;	% dz/dt = v_z
	dvxdt = qe/m*(Ex + vy*Bz - vz*By); % dv_x/dt
	dvydt = qe/m*(Ey + vz*Bx - vx*Bz); % dv_y/dt
	dvzdt = qe/m*(Ez + vx*By - vy*Bx); % dv_z/dt
	% Finally, we have to assign the calculated components
	% to the vector variable dqdt, which is
	% the output of the function	
	dqdt = [dxdt; dydt; dzdt; dvxdt; dvydt; dvzdt];

end % end of function
