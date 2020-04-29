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

DELTAn = (nm*conj(nm)-n2^2);
%{
%% TE MODE

Ecore = @(x,y)  -i * w * mew * (a/u) * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i * w * mew * (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );


grid = 2501;
x = linspace(-10^-18,3*a, grid);
y = linspace(-10^-18,3*a, grid);
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

mesh(X,Y,abs(TEfeild))

figure(2)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')
 
contourf(X,Y,abs(TEfeild))

NC = simpson2d(TEfeild.*conj(TEfeild),min(x),max(x),min(y),max(y))

C1 = 2*pi*(w * mew * (a/u))^2 *(a^2*(u*besselj(0,u)^2 -2*besselj(1,u)*besselk(1,u)+ u*besselk(1,u)^2))
C2 = 2*pi*(w*mew*(a/w)*(besselj(0,u)/besselk(0,w)))^2 * ((1/2)*a^2*(  - besselk(1,w)^2 + besselk(0,w)*besselk(2,w)))
AC =C1+C2;

r = 0.5*10^-9
r = linspace(2*r,r, 2);

grid = 3000;
for s=1:length(r)
xc = linspace( -r(s)-1*10^-10, r(s)+1*10^-10,grid);
yc = linspace( -r(s)-1*10^-10, r(s)+0.5*10^-10,grid);

[Xc,Yc] = meshgrid(xc,yc);

IndC = ones(grid,grid);
IndC = sqrt(Xc.^2 + Yc.^2) < r(s) ;
IndC = double(IndC);
Xc = Xc + a +r(s);

Ecircle = Eclad(Xc,Yc);
Ecircle = Ecircle.*IndC;
f=Ecircle.*conj(Ecircle);
f = f*DELTAn;
Int = simpson2d(f,min(xc),max(xc),min(yc),max(yc))
Int = (Int)/ NC;
NewB(s)  = sqrt(Int*B^2 +Bo^2);
dneff(s) =(NewB(s)*lambda)/(2*pi) -1.447;
end

IndOC = ones(grid,grid);
IndOC = sqrt((Xc-a-0.5*10^-9).^2 + Yc.^2) > 0.5*10^-9 ;
IndOC = double(IndOC);
Ecircle = Ecircle + Ecircle(grid/2,grid/2)*IndOC;
figure(8)
mesh(Xc,Yc,abs(Ecircle))

figure(10)
plot(r,real(dneff), 'r')
xlabel('Radius of Particle')
ylabel('Real Delta Beta')


n = linspace(100,5000,10000);
DB = @(n) n.*dneff(s);
figure(11)
fplot(DB,[0 5000])
xlabel('Number of particles')
ylabel('Real Delta effective index')
DB = @(n) n.*dneff(s) + DelNeff;
num = fzero(DB,2000)
Area = pi*(r(s))^2 * num

%}

%% TM MODE
Ecore = @(x,y)  i* Bo * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i *Bo* (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );


grid = 4001;
x = linspace(10^-14,1.4*a, grid);
y = linspace(10^-14,1.4*a, grid);
[X,Y] = meshgrid(x,y);
IndexCore = zeros(grid,grid);
IndexCladding = zeros(grid, grid);
IndexCore = sqrt(X.^2 +Y.^2) < a;
IndexCladding  = sqrt(X.^2 +Y.^2) > a;

CoreFeild = Ecore(X,Y);
CoreFeild = CoreFeild.*IndexCore;

CladdingFeild = Eclad(X,Y);
CladdingFeild = CladdingFeild.*IndexCladding;

TMfeild = CoreFeild + CladdingFeild;

figure(1)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')

mesh(X,Y,abs(TMfeild))

NC = 4*simpson2d(TMfeild.*conj(TMfeild),min(x),max(x),min(y),max(y));

r = 0.5*10^-9
r = linspace(2*r,r, 40);

grid = 1000;
for s=1:length(r)
xc = linspace( -r(s)-0.5*10^-10, r(s)+0.5*10^-10,grid);
yc = linspace( -r(s)-0.5*10^-10, r(s)+0.5*10^-10,grid);

[Xc,Yc] = meshgrid(xc,yc);

IndC = ones(grid,grid);
IndC = sqrt(Xc.^2 + Yc.^2) < r(s) ;
IndC = double(IndC);
Xc = Xc + a +r(s);

Ecircle = Eclad(Xc,Yc);
Ecircle = Ecircle.*IndC;
f=Ecircle.*conj(Ecircle);
f = f*DELTAn;
Int = simpson2d(f,min(xc),max(xc),min(yc),max(yc))
Int = (Int)/ NC;
NewB(s)  = sqrt(Int*B^2 +Bo^2);
dneff(s) =(NewB(s)*lambda)/(2*pi) -1.447;
end

IndOC = ones(grid,grid);
IndOC = sqrt((Xc-a-0.5*10^-9).^2 + Yc.^2) > 0.5*10^-9 ;
IndOC = double(IndOC);
Ecircle = Ecircle + Ecircle(grid/2,grid/2)*IndOC;
figure(8)
mesh(Xc,Yc,abs(Ecircle))

figure(10)
plot(r,real(dneff), 'r')
xlabel('Radius of Particle')
ylabel('Real Delta Beta')


n = linspace(100,5000,10000);
DB = @(n) n.*dneff(s);
figure(11)
fplot(DB,[0 500])
xlabel('Number of particles')
ylabel('Real Delta effective index')
DB = @(n) n.*dneff(s) - DelNeff;
num = fzero(DB,200)
Area = pi*(0.5*10^-9)^2 * num


%{
%% HYBRID MODES
% Jn' = 0.5*(Jn-1  - Jn+1)
% Kn' = 0.5*(Kn-1  - Kn+1)



v = 1;
n = 3;

s = (v*((1/u^2) + (1/w^2))) /  (((0.5*(besselj(v-1,u) -besselj(v+1,u)))/(u*besselj(v,u))) +((0.5*(besselk(v-1,u) -besselk(v+1,u)))/(u*besselk(v,u))));

ERcore =@(x,y) -i * B *(a/u)* (((1-s)/2)*besselj(v-1,(u/a)*sqrt(x.^2 + y.^2)) - ((1+s)/2)*besselj(v+1,(u/a)*sqrt(x.^2 + y.^2)))*cos(v*atan(y./x));

ERclad = @(x,y) -i *B* (a/w) * (besselj(v,w)/besselk(v,w)) * (((1-s)/2)*besselk(v-1,(w/a)*sqrt(x.^2 + y.^2)) + ((1+s)/2)*besselk(v+1,(w/a)*sqrt(x.^2 + y.^2)))*cos(v*atan(y./x));

l = (n*((1/u^2) + (1/w^2))) /  (((0.5*(besselj(n-1,u) -besselj(n+1,u)))/(u*besselj(n,u))) +((0.5*(besselk(n-1,u) -besselk(n+1,u)))/(u*besselk(n,u))));

ETcore = @(x,y) i * B *(a/u)* (((1-l)/2)*besselj(n-1,(u/a)*sqrt(x.^2 + y.^2)) + ((1+l)/2)*besselj(n+1,(u/a)*sqrt(x.^2 + y.^2)))*sin(n*atan(y./x));

ETclad = @(x,y) i *B* (a/w) * (besselj(n,w)/besselk(n,w)) * (((1-l)/2)*besselk(n-1,(w/a)*sqrt(x.^2 + y.^2)) - ((1+l)/2)*besselk(n+1,(w/a)*sqrt(x.^2 + y.^2)))*sin(n*atan(y./x));

format long g
grid = 2000;
x = linspace(-1.2*a,1.2*a, grid);
y = linspace(-1.2*a,1.2*a, grid);
[X,Y] = meshgrid(x,y);
IndexCore = zeros(grid,grid);
IndexCladding = zeros(grid, grid);
IndexCore = sqrt(X.^2 +Y.^2) < a;
IndexCladding  = sqrt(X.^2 +Y.^2) > a;

CoreFeild = ETcore(X,Y) + ERcore(X,Y) ;
CoreFeild = CoreFeild.*IndexCore;

CladdingFeild = ETclad(X,Y)+ ERclad(X,Y);
CladdingFeild = CladdingFeild.*IndexCladding;

HEfeild = CoreFeild + CladdingFeild;

figure(1)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')
set(gcf,'renderer','zbuffer');
mesh(X,Y,abs(CoreFeild))

figure(2)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')

contourf(X,Y,abs(CoreFeild))



NC = simpson2d(HEfeild.^2,min(x),max(x),min(y),max(y));
CladdingFeild = CladdingFeild + IndexCore*(ETclad(0,a)+ ERclad(0,a));
figure(3)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')
mesh(X,Y,abs(CladdingFeild))


theta = linspace ( 0,2*pi,100);
r= 0.5*10^-9
grid = 1000;
xc = linspace( -r, r,grid);
yc = linspace( -r, r,grid);
[Xc,Yc] = meshgrid(xc,yc);
IndC = ones(grid,grid);
IndC = sqrt(Xc.^2 + Yc.^2) < r ;
IndC = double(IndC);
5

for s=1:length(theta)


[Xc,Yc] = meshgrid(xc,yc);


Xc = Xc + (a + r)*cos(theta(s));
Yc = Yc + (a + r)*sin(theta(s));

Ecircle = ETclad(Xc,Yc);
Ecircle = Ecircle.*IndC;


f=Ecircle.^2;
f = f*DELTAn;
Int = simpson2d(f,min(xc),max(xc),min(yc),max(yc))
Int = (Int)/ NC;

Int1(s) = Int

NewB(s)  = sqrt(Int*B^2 +Bo^2);
dneff(s) =(NewB(s)*lambda)/(2*pi) -1.447;
end



figure(10)
plot(theta,Int1, 'r')
xlabel('angle of Particle location')
ylabel('Integral value')


n = linspace(100,5000,10000);
DB = @(n) (n/100).*sum(dneff);
figure(11)
fplot(DB,[0 50000])
xlabel('Number of particles')
ylabel('Real Delta Beta')
DB = @(n) n.*dneff(1) + DelNeff;
num = fzero(DB,1000)
Area = pi*(0.5*10^-9)^2 * num
%}
