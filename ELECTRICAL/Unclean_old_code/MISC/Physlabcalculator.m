clc
r=radiationdensity;
L=wavelengthnm;
L=L*10^-9;
h=8.84575*10^-34;
c=2.9*10^8;
k=1.38*10^-23;
T=3650;


a=8*pi*h*c;
b=(h*c)./(L.*k*6000);
E=(a./L.^5).*((exp(b)-1).^-1)

a=8*pi*h*c;
b=(h*c)./(L.*k*4000);
E1=(a./L.^5).*((exp(b)-1).^-1)

a=8*pi*h*c;
b=(h*c)./(L.*k*4400);
E2=(a./L.^5).*((exp(b)-1).^-1)

a=8*pi*h*c;
b=(h*c)./(L.*k*4800);
E3=(a./L.^5).*((exp(b)-1).^-1)

a=8*pi*h*c;
b=(h*c)./(L.*k*5352);
E4=(a./L.^5).*((exp(b)-1).^-1)

a=8*pi*h*c;
b=(h*c)./(L.*k*5600);
E5=(a./L.^5).*((exp(b)-1).^-1)



plot(L,r,L,E,L,E1,L,E2,L,E3,L,E4,L,E5)

