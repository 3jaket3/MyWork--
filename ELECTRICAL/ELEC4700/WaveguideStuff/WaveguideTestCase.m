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
u1 = u;
w1=w;
DELTAn =  n2-nm;

%% TE MODE

Ecore = @(x,y)  -i * w * mew * (a/u) * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i * w * mew * (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );

C1 = 2*pi*(w * mew * (a/u))^2 *(a^2*(u*besselj(0,u)^2 -2*besselj(1,u)*besselk(1,u)+ u*besselk(1,u)^2))
C2 = 2*pi*(w*mew*(a/w)*(besselj(0,u)/besselk(0,w)))^2 * ((1/2)*a^2*(  - besselk(1,w)^2 + besselk(0,w)*besselk(2,w)))
AC =C1+C2;


% NORMALIZATION

grid = 3001;
x = linspace(-10^-18,1.2*a, grid);
y = linspace(-10^-18,1.2*a, grid);
[X,Y] = meshgrid(x,y);
IndexCore = zeros(grid,grid);
IndexCladding = zeros(grid, grid);
IndexCore = sqrt(X.^2 +Y.^2) < a;
IndexCladding  = sqrt(X.^2 +Y.^2) > a;

CoreFeild = Ecore(X,Y);
CoreFeild = CoreFeild.*IndexCore;

CladdingFeild = Eclad(X,Y);
CladdingFeild = CladdingFeild.*IndexCladding;
TEfeild = CoreFeild + CladdingFeild;

N = 4*simpson2d(TEfeild.*conj(TEfeild),min(x),max(x),min(y),max(y));
N = (1/sqrt(N));


Ecore = @(x,y)  -i * N *w * mew * (a/u) * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i *N* w * mew * (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );



CoreFeild = Ecore(X,Y);
CoreFeild = CoreFeild.*IndexCore;

CladdingFeild = Eclad(X,Y);
CladdingFeild = CladdingFeild.*IndexCladding;

TEfeild = CoreFeild + CladdingFeild;

figure(1)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')

mesh(X,Y,abs(TEfeild))

NC = 4*simpson2d(TEfeild.*conj(TEfeild),min(x),max(x),min(y),max(y));

grid = 3500;
r = a;
r1 = a +1*10^-6;
xc =linspace(10^-18*a,1.2*a, grid);
yc = linspace(-10^-18*a,1.2*a, grid);

[Xc,Yc] = meshgrid(xc,yc);

IndCr = ones(grid,grid);
IndCr = sqrt(Xc.^2 + Yc.^2) > r ;
IndCr = double(IndCr);

IndCr1 = ones(grid,grid);
IndCr1 = sqrt(Xc.^2 + Yc.^2) < r1 ;
IndCr1 = double(IndCr1);


Ecircle = Eclad(Xc,Yc);
Ecircle = Ecircle.*IndCr.*IndCr1;
f=Ecircle.*conj(Ecircle);
f = f*(DELTAn.*conj(DELTAn));
Int = 4*simpson2d(f,min(xc),max(xc),min(yc),max(yc))
Int = (Int)/NC;

NewB = sqrt(Int*B^2 +Bo^2);
newN = (NewB*lambda)/(2*pi)
dneff = newN-1.444

