% Lab 3 analytical calculations

clear 
clc
close all

P = 100*10^3;
E = 170*10^9;
L = 2*10^-3;
a = 120*10^-6;
b = 11*10^-6;
c = 200*10^-6;
H = 20*10^-6;
Rs = 250;

 
a2 = (L^2 * P)/(2*E*H^3);
a3 = -(L*P)/(E*H^3);
a4 = P/(2*E*H^3);

w = @(x) (a2 * x^2 + a3 * x^3 + a4 * x^4)/2 ;

s = @(x) E*H*(a2 + 3*a3*x + 6*a4*x^2)*10^-6;


figure(1)
fplot(w,[0 L])
title('Displacement Vs Position')
xlabel('Position [mm]')
ylabel('displacement [m]')
figure(2)
fplot(s,[0 L])
title('Stress Vs Position')
xlabel('Position [mm]')
ylabel('Stress [Pa/micro meter]')
% assuming Rs ohms/[]  means a unit cell
fprintf('The maximum displacement is %f\n\n',w(L/2))
fprintf('The stress at the center is %f N/m^2\n\n',s(L/2))

R1 = Rs * 200* 11;

x = linspace(0,L,1000);
y = linspace(0,L,1000);

[X Y] = meshgrid(x,y);
Z = ((a2 * X.^2 + a3 * X.^3 + a4 * X.^4 ))/2;
S =  ((E*H)*(a2 + 3*a3*X + 6*a4*X.^2)*10^-6 );
figure(3)
mesh(X,Y,Z)
view(135, 45)

xi = L/2-c/2;
xii = L/2+c/2;
yi = a;
yii = a+b;
x1 = linspace(xi,xii,2000);
y1 = linspace(yi,yii,2000);
[X1 Y1] = meshgrid(x1,y1);

Z1 = (a2 * X1.^2 + a3 * X1.^3 + a4 * X1.^4 )/2;
simpson2d(Z1,xi,yi,xii,yii)

figure(4)
mesh(X1,Y1,Z1)
view(135, 45)

xi = a/2 +c/2;
xii = a/2 -c/2;
yi = L/2-b/2;
yii = L/2+b/2;
x1 = linspace(xi,xii,2000);
y1 = linspace(yi,yii,2000);
[X2 Y2] = meshgrid(x1,y1);
Z2 = (a2 * X2.^2 + a3 * X2.^3 + a4 * X2.^4 )/2;
simpson2d(Z2,xi,yi,xii,yii)

figure(5)
mesh(X2,Y2,Z2)
view(135,45)

figure(6)
mesh(X,Y,S)