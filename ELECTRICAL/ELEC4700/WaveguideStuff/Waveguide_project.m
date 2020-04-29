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
nm = 0.5 - 11i;
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

% Initial Plot

grid =300;
rho= linspace(0,a,grid);
theta = linspace(0,2*pi,grid);

for t=1:length(rho)
 rho1(:,t) =rho;
 theta1(t,:) = theta;
    
end


x= rho1.*cos(theta1);
y= rho1.*sin(theta1);




Ecore = @(x,y)  -i * w * mew * (a/u) * besselj(1,(u/(a)).*sqrt( x.^2 +y.^2 ) );


Z = Ecore (x,y);


figure(3)
hold on
mesh(x,y,abs(Z))


Eclad = @(x,y) -i * w * mew * (a/w) * (besselj(0,u)/besselk(0,w)) * besselk(1,(w/(a)).*sqrt( x.^2 +y.^2 ) );
rho2= linspace(a,(3/2)*a,2*grid);
theta2 = linspace(0,2*pi,2*grid);

for t=1:length(rho2)
 rho3(:,t) =rho2;
 theta3(t,:) = theta2;
    
end

x1= rho3.*cos(theta3);
y1= rho3.*sin(theta3);

Z2 =Eclad(x1,y1);

figure(3)
mesh(x1,y1,abs(Z2))
figure(4)
mesh(x1,y1,abs(Z2))



%% 
% Integral setup
% Integral(Ecor) = (a^2(uJo(u)^2 - 2J1(u)Jo(u) + J1(u)^2))/2u
%indefintie integral 
%integral(Eclad) = (1/2)x^2[K1(wx/a)^2 - K0(wx/a)K2(wx/a)];
% assuming that at infinity the value of the function is 0 so take -a for x
% to get

%integral(Eclad) = (1/2)a^2[K1(w)^2 -K0(w)K2(w)]

C1 = 2*pi*(w * mew * (a/u))^2 *(a^2*(u*besselj(0,u)^2 -2*besselj(1,u)*besselk(1,u)+ u*besselk(1,u)^2));
C2 = 2*pi*(w*mew*(a/w)*(besselj(0,u)/besselk(0,w)))^2 * ((1/2)*a^2*(  - besselk(1,w)^2 + besselk(0,w)*besselk(2,w))); 
C = (B^2*DELTAn)/(C1+C2);
%% Circular particle
r= 5*10^-10


grid =2001;


rp= linspace(0,r,grid);
phi = linspace(0,2*pi,grid);

for t=1:length(rp)
 rp1(:,t) =rp;
 phi1(t,:) = phi;
    
end


x= rp1.*cos(phi1);
y= rp1.*sin(phi1);
x = x +a+r/2;

Eparticle = Eclad(x,y);
figure(8)
mesh(x,y,abs(Eparticle));


r = linspace(2*r,r, 40);

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
figure(9)
mesh(Xc,Yc,abs(Ecircle))
f=Ecircle.^2;
Int = simpson2d(f,min(xc),max(xc),min(yc),max(yc))
Int = Int*C;
DelB(s) = Int;
end
Int
figure(10)
plot(r,real(DelB), 'r')
xlabel('Radius of Particle')
ylabel('Real Delta Beta')


n = linspace(1,500,500);
DB = n.*Int;
figure(11)
plot(n, real(DB),'k')
xlabel('Number of particles')
ylabel('Real Delta Beta')

NuMP = DelNeff/real(Int)
%% Square particle

L= 1*10^-9;
W =1*10^-9;

w=linspace(a,a+W,grid);
l=linspace(-(L/2),(L/2),grid);
[W1,L1] = meshgrid(w,l);


ParticleSQ = Eclad(W1,L1);
figure(6) 

mesh(W1,L1,abs(ParticleSQ))



INT2 = C*simpson2d(ParticleSQ.^2,min(w),max(w),min(l),max(l))


%% Eliptical
grid =501;
L2= 0.5*10^-9;
W2=1*10^-9;
phi = linspace(0,2*pi,grid);
w=linspace(0,W2/2,grid);
l=linspace(0,L2/2,grid);


for t=1:length(w)
 Er1(:,t) =(w.*l) ./sqrt( w.^2 - (l.*cos(phi(t))).^2); 
 phi2(t,:) = phi;
    
end
Er1(1,:)=0;
Ex= Er1.*cos(phi2)+a+(L2/2);
Ey = Er1.*sin(phi2);

ParticleEL = Eclad(Ex,Ey);
figure(7) 

mesh((Ex),(Ey),abs(ParticleEL))

L2= 0.1*10^-9;
W2=1*10^-9;


xE = linspace(-2*L2,L2*2,grid);
yE = linspace(-W2*2,W2*2,grid);
[XE,YE] = meshgrid(xE,yE);

IndE = zeros(grid,grid);
IndE =  XE.^2/L2^2 + YE.^2/W2^2 < 1;
IndE = double(IndE);

XE = XE + a + L2/2;

figure(8)
mesh(XE,YE,IndE)

ElipticalE = Eclad(XE,YE);
ElipticalE = IndE.*ElipticalE.^2;


INT3 = C*simpson2d((ElipticalE),min(xE),max(xE),min(yE),max(yE))

