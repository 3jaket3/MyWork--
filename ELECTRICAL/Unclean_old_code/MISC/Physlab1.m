%Physics 3701 lab1 calculations
clc
r=radiationdensity;
L=wavelengthnm;

h= 6.845e-34;
c=2.9*10^8;
k=1.38*10^-23;
T=3650;
a=8*pi*h(1)*c;
b=(h(1)*c)./(L.*k*T);
E=(a./L.^5).*((exp(b)-1).^-1)

plot(L,E)

