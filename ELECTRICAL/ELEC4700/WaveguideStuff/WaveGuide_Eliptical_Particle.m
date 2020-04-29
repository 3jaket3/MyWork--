%Jake Tully 100904392
%
% TE Modes optical waveguide
% Eliptical Nano particals on core

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
x = linspace(10^-18,3*a, grid);
y = linspace(10^-18,3*a, grid);
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

grid = 2000;

L= 0.5*10^-9;
W=1.25*10^-9;
L = linspace(L,2*L,50);

for s = 1:length(L)
xE = linspace(-2*L(1),L(1)*2,grid);
yE = linspace(-W*3,W*3,grid);
[XE,YE] = meshgrid(xE,yE);

IndE = zeros(grid,grid);
IndE =  XE.^2/L(s)^2 + YE.^2/W^2 < 1;
IndE = double(IndE);

IndOE = zeros(grid,grid);
IndOE =  XE.^2/L(s)^2 + YE.^2/W^2 > 1;
IndOE = double(IndOE);

XE = XE + a + L(s);

ElipticalE = Eclad(XE,YE);

ElipticalE = ElipticalE.*IndE;

f = (ElipticalE.*conj(ElipticalE));
f = DELTAn*f;

Int = simpson2d(f,min(xE),max(xE),min(yE),max(yE))
Int = (Int)/ NC;
NewB(s)  = sqrt(Int*B^2 +Bo^2);
dneff(s) =(NewB(s)*lambda)/(2*pi) -1.447;

ElipticalE= IndE.*ElipticalE + IndOE*ElipticalE(1000,1000);

view(2)

end

figure(13)
mesh(XE,YE,abs(ElipticalE))
view(2)
ElipticalE = IndE.*ElipticalE;


figure(10)
plot(L,real(dneff), 'r')
xlabel('Length of Particle')
ylabel('Real Delta Beta')


n = linspace(100,5000,10000);
DB = @(n) n.*dneff(s);
figure(11)
fplot(DB,[0 5000])
xlabel('Number of particles')
ylabel('Real Delta effective index')
DB = @(n) n.*dneff(s) + DelNeff;
num = fzero(DB,2000)
Area = pi*W*L(s) * num

%{

%% TM MODE

Ecore = @(x,y)  i* B * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i *B* (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );

grid = 4000;
x = linspace(-4*a,4*a, grid);
y = linspace(-4*a,4*a, grid);
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

grid = 1000;

L= 0.1*10^-9;
W=0.75*10^-9;
W = linspace(W,2*W,100);

for s = 1:length(W)
xE = linspace(-2*L,L*2,grid);
yE = linspace(-W(1)*3,W(1)*3,grid);
[XE,YE] = meshgrid(xE,yE);

IndE = zeros(grid,grid);
IndE =  XE.^2/L^2 + YE.^2/W(s)^2 < 1;
IndE = double(IndE);

IndOE = zeros(grid,grid);
IndOE =  XE.^2/L^2 + YE.^2/W(s)^2 > 1;
IndOE = double(IndOE);

XE = XE + a + L;

ElipticalE = Eclad(XE,YE);
ElipticalE= IndE.*ElipticalE + IndOE*ElipticalE(500,500);
figure(8)
mesh(XE,YE,abs(ElipticalE))
view(2)


ElipticalE = IndE.*ElipticalE;

ElipticalE = DELTAn*ElipticalE.^2;


Int = simpson2d((ElipticalE),min(xE),max(xE),min(yE),max(yE))
Int = (Int*B)/ NC;
NewB(s) = Bo +Int;
end
DelB =(Bo-NewB)/Bo

Int
figure(10)
plot(W,real(DelB), 'r')
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



grid = 4000;
x = linspace(-4*a,4*a, grid);
y = linspace(-4*a,4*a, grid);
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

contourf(X,Y,abs(HEfeild))

NC = simpson2d(HEfeild.^2,min(x),max(x),min(y),max(y));

grid = 500;

L= 0.1*10^-9;
W=0.75*10^-9;
theta = linspace ( 0,2.3*pi,50);

R = zeros(grid,grid);
PHI = zeros(grid,grid);
for s = 1:length(theta)
xE = linspace(0,2*L,grid);
yE = linspace(-2*W,W*2,grid);


[XE,YE] = meshgrid(xE,yE);

IndE = zeros(grid,grid);
IndE =  (XE-L).^2/L^2 + YE.^2/W^2 < 1;
IndE = double(IndE);

IndOE = zeros(grid,grid);
IndOE =  (XE-L).^2/L^2 + YE.^2/W^2 > 1;
IndOE = double(IndOE);


R = sqrt(XE.^2 +YE.^2);
PHI = atan(YE./XE);
PHI = PHI + theta(s);

XE= R.*cos(PHI);
YE = R.*sin(PHI);

XE = XE + a* cos(theta(s));
YE = YE + a *sin(theta(s));


ElipticalE = ETclad(XE,YE);

ElipticalE = ElipticalE.*IndE + IndOE.*ElipticalE(grid/2,grid/2);

 x= a*cos(theta(s))
y=a*sin(theta(s))
XE(250,2)
YE(250,2)
figure(8)

mesh(XE,YE,abs(ElipticalE))
 view(2)
ElipticalE = ElipticalE.*IndE;
pause(5)

ElipticalE = DELTAn*ElipticalE.^2;


Int = simpson2d((ElipticalE),min(xE),max(xE),min(yE),max(yE))
Int = (Int*B)/ NC;
NewB(s) = Bo +Int;
end
hold off
DelB =(Bo-NewB)/Bo

Int
figure(10)
plot(theta,real(DelB), 'r')
xlabel('length of Particle')
ylabel('Real Delta Beta')


n = linspace(1,500,500);
DB = n.*DelB(1);
figure(11)
plot(n, real(DB),'k')
xlabel('Number of particles')
ylabel('Real Delta Beta')

NuMP = DelNeff./real(DelB)
%}