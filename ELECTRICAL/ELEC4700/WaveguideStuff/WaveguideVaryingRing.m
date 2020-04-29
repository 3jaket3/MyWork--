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
a =1*10^-6;
k = sqrt((f)/((n1^2-n2^2)*a^2));

kapa = sqrt(B^2*n1^2 - Bo^2);
sigma = sqrt(Bo^2 - B^2*n2^2);

u = kapa*a;
w = sigma*a;
u1 = u;
w1=w;
DELTAn = 1.09;

a = linspace(a,30*a,20);
%% TE MODE

for s=1:length(a)
    
    u = kapa*a(s);
w = sigma*a(s);
Ecore = @(x,y)  -i * w * mew * (a(s)/u) * besselj(1,(u/(a(s))).*sqrt( x.^2 +y.^2 ) );
Eclad = @(x,y) -i * w * mew * (a(s)/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a(s))).*sqrt( x.^2 +y.^2 ) );


grid = 4001;
x = linspace(-1.4*a(s),1.4*a(s), grid);
y = linspace(-1.4*a(s),1.4*a(s), grid);
[X,Y] = meshgrid(x,y);
IndexCore = zeros(grid,grid);
IndexCladding = zeros(grid, grid);
IndexCore = sqrt(X.^2 +Y.^2) < a(s);
IndexCladding  = sqrt(X.^2 +Y.^2) > a(s);

CoreFeild = Ecore(X,Y);
CoreFeild = CoreFeild.*IndexCore;

CladdingFeild = Eclad(X,Y);
CladdingFeild = CladdingFeild.*IndexCladding;

TEfeild = CoreFeild + CladdingFeild;

figure(1)
title('Feild over large region')
xlabel('X -direction')
ylabel('Y -direction')
if mod(s,5) == 0
contourf(X,Y,abs(TEfeild))
end
NC = simpson2d(TEfeild.^2,min(x),max(x),min(y),max(y));

grid = 3000;
r = a(s);
r1 = a(s) +1*10^-6;
xc =linspace(-1.2*a(s),1.2*a(s), grid);
yc = linspace(-1.2*a(s),1.2*a(s), grid);

[Xc,Yc] = meshgrid(xc,yc);

IndCr = ones(grid,grid);
IndCr = sqrt(Xc.^2 + Yc.^2) > r ;
IndCr = double(IndCr);

IndCr1 = ones(grid,grid);
IndCr1 = sqrt(Xc.^2 + Yc.^2) < r1 ;
IndCr1 = double(IndCr1);


Ecircle = Eclad(Xc,Yc);
Ecircle = Ecircle.*IndCr.*IndCr1;
f=Ecircle.^2;
f = f*DELTAn;
Int = simpson2d(f,min(xc),max(xc),min(yc),max(yc));
Int = (Int)/ NC;

NewB = sqrt(Int*B^2 +Bo^2);
newN(s) = (NewB*lambda)/(2*pi)
dneff(s) = newN(s)-1.443953;

fprintf( 'the value of the integral is %f e-9 and the new beta is %f \n\n ', Int*10^9,NewB)
fprintf( 'the change in effective refractive index is %f,\n the new effective index is %f \n',dneff(s), newN(s))

end

figure(6)
plot(a,newN,'r')
figure(7)
plot(a,dneff)
