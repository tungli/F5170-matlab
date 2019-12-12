function dqdt = odefun(t, q),
    % We will use global variables defined in solve.m
	global p;
	global kB;
	global Tg;
	global Te;
    
    % the vector q contains the densities of Ar*, Ar+, Ar_2+ and electrons 
	nArs = q(1);
	nArp = q(2);
	nAr2p = q(3);
	ne = q(4);
    % the density of argon is calculated using the state equation and the
    % densities of other heavy species
	nAr = p./(kB*Tg)-nArs-0.5*nAr2p-nArp;

    % The rate coefficients are all stored in separate function files
	k1 = f_k1(Te, Tg);
	k2 = f_k2(Te, Tg);
	k3 = f_k3(Te, Tg);
	k4 = f_k4(Te, Tg);
	k5 = f_k5(Te, Tg);
	k6 = f_k6(Te, Tg); 
	k7 = f_k7(Te, Tg); 
	k8 = f_k8(Te, Tg); 
	k9 = f_k9(Te, Tg); 
	k10 = f_k10(Te, Tg); 
	k11 = f_k11(Te, Tg); 
    
    % Now, it is necessary to define the source terms
	SArs = 	+k1*ne*nAr ...
		-k2*ne*nArs ...
		-k4*ne*nArs ...
		+k6*ne*nAr2p ...
		-2*k10*nArs*nArs ...
		-k11*nArs*nAr;
	SArp = 	... ;
	SAr2p = ... ;
	Se = 	... ;
    
    % and finally, the derivative of the input vector is returned
	dqdt = [SArs; SArp; SAr2p; Se];
end
