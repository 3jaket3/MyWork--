%Jake Tully 100904392
%
% TE Modes optical waveguide
% Nano particals on core

clear
clc
close all

%Parameters
c = 299792458; % m/s
lambda = 1550*10^-9;
f = c/lambda;
up = lambda*f;
n1 = 1.45;
n2 = 1.44;
nm = 0.5 ;
DelNeff = 10^-5;
Bo = (2*pi*1.447)/lambda;
B =(2*pi)/lambda;
epsilon1 = (8.8541878176*10^-12)*n1^2;
mew = 1.25663706*10^-6;
a =4.1*10^-6;
k = sqrt((f)/((n1^2-n2^2)*a^2))

kapa = sqrt(B^2*n1^2 - Bo^2);
sigma = sqrt(Bo^2 - B^2*n2^2);

u = kapa*a
w = sigma*a

DELTAn = (nm^2-n2^2);

%% TE MODE

Ecore = @(x,y)  -i * w * mew * (a/u) * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i * w * mew * (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );


grid = 4000;
x = linspace(-10^-18,4*a, grid);
y = linspace(-10^-18*a,4*a, grid);
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

figure(1)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')

contourf(X,Y,abs(TEfeild))

NC = 4*simpson2d(TEfeild.*conj(TEfeild),min(x),max(x),min(y),max(y));

C1 = 2*pi*(w * mew * (a/u))^2 *(a^2*(u*besselj(0,u)^2 -2*besselj(1,u)*besselk(1,u)+ u*besselk(1,u)^2));
C2 = 2*pi*(w*mew*(a/w)*(besselj(0,u)/besselk(0,w)))^2 * ((1/2)*a^2*(  - besselk(1,w)^2 + besselk(0,w)*besselk(2,w)));
AC =C1+C2;

l = 0.5*10^-9;
w = 0.5*10^-9;

w= linspace(w,2*w,40)

grid = 1000;

for s=1:length(w)
xc = linspace(-w(s)/2,w(s)/2,grid);
yc = linspace(-l/2,l/2,grid) ;
[Xc,Yc] = meshgrid(xc,yc);


Xc = Xc + a +w(s)/2;

Esquare = Eclad(Xc,Yc);

f=Esquare.*conj(Esquare);
f = f*DELTAn;
Int = simpson2d(f,min(xc),max(xc),min(yc),max(yc))
Int = (Int)/ NC;
NewB(s)  = sqrt(Int*B^2 +Bo^2);
dneff(s) =(NewB(s)*lambda)/(2*pi) -1.447;
end


mesh(Xc,Yc,abs(Esquare))

figure(10)
plot(w,real(dneff), 'r')
xlabel('Length of Particle')
ylabel('Real Delta Beta')


n = linspace(100,5000,10000);
DB = @(n) n.*dneff(s);
figure(11)
fplot(DB,[0 5000])
xlabel('Number of particles')
ylabel('Real Delta effective index')
DB = @(n) n.*dneff(s) + DelNeff;
num = fzero(DB,1000)
Area = l*w(s) * num

%{
%% TM MODE
Ecore = @(x,y)  i* B * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i *B* (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );


grid = 4000;
x = linspace(-2*a,2*a, grid);
y = linspace(-2*a,2*a, grid);
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

figure(1)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')

contourf(X,Y,abs(TEfeild))

NC = simpson2d(TEfeild.^2,min(x),max(x),min(y),max(y));

l = 0.5*10^-9
l= linspace(l,2*l,40)
w = 1*10^-9

grid = 1000;
for s=1:length(l)
xs = linspace(-w/2,w/2,grid);
ys = linspace(-l(s)/2,l(s)/2,grid) ;
[Xs,Ys] = meshgrid(xs,ys);


Xs = Xs + a +w/2;

Esquare = Eclad(Xs,Ys);

f=Esquare.^2;
f = f*DELTAn;
Int = simpson2d(f,min(xs),max(xs),min(ys),max(ys))
Int = (Int*B^2)/ NC;
NewB(s) = Bo +abs(Int);
end
DelB =(Bo-NewB)/Bo;

Int
figure(10)
plot(l,real(DelB), 'r')
xlabel('length of Particle')
ylabel('Real Delta Beta')


n = linspace(1,500,500);
DB = n.*DelB(1);
figure(11)
plot(n, real(DB),'k')
xlabel('Number of particles')
ylabel('Real Delta Beta')

NuMP = DelNeff./real(DelB)


%% HYBRID MODES
% Jn' = 0.5*(Jn-1  - Jn+1)
% Kn' = 0.5*(Kn-1  - Kn+1)



n = 2;
s = (n*((1/u^2) + (1/w^2))) /  (((0.5*(besselj(n-1,u) -besselj(n+1,u)))/(u*besselj(n,u))) +((0.5*(besselk(n-1,u) -besselk(n+1,u)))/(u*besselk(n,u))));

ERcore =@(x,y) -i * B *(a/u)* (((1-s)/2)*besselj(n-1,(u/a)*sqrt(x.^2 + y.^2)) - ((1+s)/2)*besselj(n+1,(u/a)*sqrt(x.^2 + y.^2)))*cos(n*atan(y./x));
ETcore = @(x,y) i * B *(a/u)* (((1-s)/2)*besselj(n-1,(u/a)*sqrt(x.^2 + y.^2)) + ((1+s)/2)*besselj(n+1,(u/a)*sqrt(x.^2 + y.^2)))*sin(n*atan(y./x));

ERclad = @(x,y) -i *B* (a/w) * (besselj(n,w)/besselk(n,w)) * (((1-s)/2)*besselk(n-1,(w/a)*sqrt(x.^2 + y.^2)) + ((1+s)/2)*besselk(n+1,(w/a)*sqrt(x.^2 + y.^2)))*cos(n*atan(y./x));
ETclad = @(x,y) i *B* (a/w) * (besselj(n,w)/besselk(n,w)) * (((1-s)/2)*besselk(n-1,(w/a)*sqrt(x.^2 + y.^2)) - ((1+s)/2)*besselk(n+1,(w/a)*sqrt(x.^2 + y.^2)))*sin(n*atan(y./x));


grid = 400;
x = linspace(-1.1*a,1.1*a, grid);
y = linspace(-1.1*a,1.1*a, grid);
[X,Y] = meshgrid(x,y);
IndexCore = zeros(grid,grid);
IndexCladding = zeros(grid, grid);
IndexCore = sqrt(X.^2 +Y.^2) < a;
IndexCladding  = sqrt(X.^2 +Y.^2) > a;

CoreFeild = ETcore(X,Y);
CoreFeild = CoreFeild.*IndexCore;

CladdingFeild = ETclad(X,Y);
CladdingFeild = CladdingFeild.*IndexCladding;

HEfeild = CoreFeild + CladdingFeild;

figure(1)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')

mesh(X,Y,abs(CladdingFeild))
NC = simpson2d(HEfeild.^2,min(x),max(x),min(y),max(y));


theta = linspace ( 0,2.3*pi,100);
l = 0.5*10^-9
w = 1*10^-9

grid = 1000;
for s=1:length(theta)
xs = linspace(-w/2,w/2,grid);
ys = linspace(-l/2,l/2,grid) ;
[Xs,Ys] = meshgrid(xs,ys);
%rotate 
Xs = Xs.*cos(theta(s)) - Ys.*sin(theta(s));
Ys = Xs.*sin(theta(s)) - Ys.*cos(theta(s));

Xs = Xs + (a + w/2)*cos(theta(s));
Ys = Ys + (a + w/2)*sin(theta(s));


Esquare = ETclad(Xs,Ys);
pause(3)
figure(2)
mesh(Xs,Ys,abs(Esquare))
pause(3)
f=Esquare.^2;
f = f*DELTAn;
Int = simpson2d(f,min(xs),max(xs),min(ys),max(ys))
Int = (Int*B)/ NC;
NewB(s) = Bo +abs(Int);
end
DelB =(Bo-NewB)/Bo;

Int
figure(10)
plot(theta,real(DelB), 'r')
xlabel('position of Particle in radians')
ylabel('Real Delta Beta')


n = linspace(1,500,500);
DB = n.*DelB(1);
figure(11)
plot(n, real(DB),'k')
xlabel('Number of particles')
ylabel('Real Delta Beta')

NuMP = DelNeff./real(DelB)
%}