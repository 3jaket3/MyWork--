%Jake Tully 100904392
%
% TE Modes optical waveguide
% circular Nano particals on core

clear
clc
close all

%Parameters
c = 299792458; % m/s
lambda = 1550*10^-9;
f = c/lambda;
up = lambda*f;
n1 = 1.444;
n2 = 1;
nm = 0.5 - 11i;
DelNeff = 10^-5;
Bo = (2*pi*1.443953)/lambda;
B =(2*pi)/lambda;
epsilon1 = (8.8541878176*10^-12)*n1^2;
mew = 1.25663706*10^-6;
a =50*10^-6;
k = sqrt((f)/((n1^2-n2^2)*a^2));

kapa = sqrt(B^2*n1^2 - Bo^2);
sigma = sqrt(Bo^2 - B^2*n2^2);

u = kapa*a;
w = sigma*a;
u1 = u
w1=w
DELTAn = 1.09;

%% TE MOD)

Ecore = @(r)  -i * w * mew * (a/u) * besselj(1,(u/(a)).*r );
Eclad = @(r) -i * w * mew * (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*r );

r = linspace(1*10^-18, 2*a , 10000000);

indCore = abs(r) < a ;
indClad = abs(r) > a ;
indCore = double(indCore);
indClad = double(indClad);


ECore = Ecore(r).*indCore;
EClad = Eclad(r).*indClad;
figure(2)


Efeild = ECore + EClad;

figure(1)
plot(r, abs(Efeild))


Nc = 2*pi*simpson1D( Efeild.*conj(Efeild) ,min(r) , max(r) );


ptw = 1*10^-9;

r1 = linspace( a , a + 10^-6, 1000000);

Eparticle = Eclad(r1);

figure(2)
plot(r1,abs(Eparticle))

theta = atan(ptw/a);

Int = 2*pi*simpson1D( 1.09*(Eparticle.*conj(Eparticle))  ,min(r1) , max(r1) )


Int = (Int/Nc)

NewB = sqrt(Int*B^2 +Bo^2);
newN = (NewB*lambda)/(2*pi)
dneff = newN-1.443953










