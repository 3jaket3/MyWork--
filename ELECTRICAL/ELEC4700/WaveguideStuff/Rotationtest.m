clear 
clc 
close all

 
 
 x= 5;
 y = 0

L= 0.1*10^-6;
W=0.75*10^-6;
theta = linspace ( 0,2.3*pi,50);
a =4.1*10^-6;
grid = 200;
R = zeros(grid,grid);
PHI = zeros(grid,grid);
Z = zeros(grid,grid);
for s = 1:length(theta)


  
xE = linspace(0,W*2,grid);
yE = linspace(-2*W,W*2,grid);


[XE,YE] = meshgrid(xE,yE);

IndE = zeros(grid,grid);
IndE =  (XE-L).^2/L^2 + YE.^2/W^2 < 1;
IndE = double(IndE);

XE = XE.*IndE;
YE = YE.*IndE;


R = sqrt(XE.^2 +YE.^2);
PHI = atan(YE./XE);
PHI = PHI + theta(s);

XE= R.*cos(PHI);
YE = R.*sin(PHI);

XE = XE + a* cos(theta(s));
YE = YE + a *sin(theta(s));

pause(30)
figure(1)
hold on
view(2)
 mesh(XE,YE,Z)
 view(2)

end