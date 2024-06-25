%eqns 
eqns = struct; 

syms thta1_dd Jo thta2_dd m2 L1 l2 thta2 thta1_d thta2_d J2 b1 b2 tau1 tau2 g

eqns.eqn1 = [char(tau1) ' = ' char(thta1_dd*(Jo+J2*sin(thta2)^2)+thta2_dd*m2*L1*l2*cos(thta2)-m2*L1*l2*sin(thta2)*thta2_d^2 + thta1_d*thta2_d*J2*sin(2*thta2)+b1*thta1_d)];
eqns.eqn2 = [ char(tau2) ' = '  char(thta1_dd*m2*L1*l2*cos(thta2)+thta2_dd*J2 - 1/2*thta1_d^2*J2*sin(2*thta2) + b2*thta2_d + g*m2*l2*sin(thta2))];
eqns.eqn3 = [char(thta1_d) ' = ' char(thta1_d)];

X = {'thta1_d', 'thta2', 'thta2_d'};
dX = {'thta1_dd', 'thta2_d', 'thta2_dd'};


U = {'tau1'};

eom2ss(eqns,X,dX,U)