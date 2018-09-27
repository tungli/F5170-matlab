function dqdt = odefun(t,q),
	% This is the input function for the 
	% ordinary differential equation solver ode45.
	% Input: independent variable t(time), 6-dim vector q
	% q = [x,y,z,v_x,v_y,v_z]
	% Output: time derivative of q, dqdt = dq/dt
	
	% In solve.m, we define some global variables. Now, we need to tell
	% Matlab, that we will use "m" and "qe"
	global m; global qe;

	% Re-naming position and velocity variables
	x = q(1);	
	y = q(2);
	z = q(3);
	vx = q(4);
	vy = q(5);
	vz = q(6);

	% The electric field is zero here
	Ex = 0;
	Ey = 0;
	Ez = 0;

	% The magnetic field is now calculated using another function, bfield(r)
	% which is a function of the position vector. The function is stored in bfield.m
	r0 = [q(1), q(2), q(3)];	% The position vector
	B = bfield(r0); 		% the function returns a vector B ...
	% ... and we use this vector to define our component-wise B-field variables
	Bx = B(1);
	By = B(2);
	Bz = B(3);

	% Now, we calculate the components of the 6-dim vector dq/dt.
	dxdt = vx;	% dx/dt = v_x
	dydt = vy;	% dy/dt = v_y
	dzdt = vz;	% dz/dt = v_z
	dvxdt = qe/m*(Ex + vy*Bz - vz*By); % dv_x/dt
	dvydt = qe/m*(Ey + vz*Bx - vx*Bz); % dv_y/dt
	dvzdt = qe/m*(Ez + vx*By - vy*Bx); % dv_z/dt
	% Finally, we have to assign the calculated components to the vector 
	% variable dqdt, which is the output of the function	
	dqdt = [dxdt; dydt; dzdt; dvxdt; dvydt; dvzdt];

end % end of function
