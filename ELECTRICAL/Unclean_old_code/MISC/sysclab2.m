km = 1.5275;
J = 100 ;
b = 100 ;
Ra = 1 ;
N = 12;
k1 = 12 ;
k2 = k1;
B=km/(Ra*J)
C=(Ra*b+km*km)/(Ra*J)
A=300; 
damping = ((b+km^2)/(J))/(2*wn)
wd = wn*sqrt(1-damping^2)
damping = 1;
kr = (2*wn)/(C+A*B)