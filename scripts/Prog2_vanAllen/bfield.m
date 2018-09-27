function B = bfield(r0),
	% The function calculates the geomagnetic field B at the position r0. It works with cartesian coordinates.
	% The function uses the following global variables:
	global Re; global q; global m; global mu0; global M;

	% If you did the exercises, the lines below should be clear
	x = r0(1);
	y = r0(2);
	z = r0(3);
	r = sqrt(x^2+y^2+z^2);

	C = mu0*M/(4*pi*r^5);
	
	Bx = XXX;
	By = YYY;
	Bz = ZZZ;
	
	B = [Bx; By; Bz];
end
