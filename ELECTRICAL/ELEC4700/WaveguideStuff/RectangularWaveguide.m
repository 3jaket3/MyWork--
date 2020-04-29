%Jake Tully 100904392
%
% TE Modes optical waveguide
% circular Nano particals on square waveguide

clear
clc
close all

%Parameters
c = 299792458; % m/s
lambda = 1550*10^-9;
f = c/lambda;
up = lambda*f;
no = 1;
n1 = 1.444;
nm = 0.5 - 11i;
DelNeff = 10^-5;
Bo = (2*pi*1.443953)/lambda;
B =(2*pi)/lambda;
e1 = (8.8541878176*10^-12)*n1^2;
mew = 1.25663706*10^-6;
a =30*10^-6;
d =60*10^-6;
w = 2*pi*f;
k = (2*pi)/lambda;

DELTAn = 1.09;
p=2;
q=4;
phi = (p-1)*(pi/2);
sih = (q-1)*(pi/2);

fy = @(kx) ( kx*(tan(kx*d) - tan(phi)))/sqrt(k^2*(n1^2 - no^2) - kx^2) -1
figure(1)
fplot(fy, [-1 1])
ky = fzero(fy,0)*10^14

gy = sqrt(k^2*(n1^2 -no^2) -ky^2)

kx = @(kx) ( kx*no^2*(tan(kx*a) - tan(sih))/n1^2)/sqrt(k^2*(n1^2 - no^2) - kx^2) -1
figure(2)
fplot(kx, [-1 1])
kx = fzero(kx,0)*10^14

gx = sqrt(k^2*(n1^2 -no^2) -kx^2)

B1 = sqrt( - kx^2 -ky^2 +k^2*n1);

Eregion1 = @(x,y) ((w*mew)/B1)* cos(kx.*x-phi)*cos(ky.*y-sih) +(1/(w*e1*B1))*kx^2*cos(kx.*x-phi)*cos(ky.*y-sih) +(1/(w*e1*B1))*kx*ky*sin(kx.*x-phi)*sin(ky.*y-sih);

grid = 2000;
x = linspace(-a,a,grid);
y = linspace(-d,d,grid);

[X,Y] = meshgrid(x,y);

E = Eregion1(X,Y);

figure(3)
mesh(X,Y,E)



