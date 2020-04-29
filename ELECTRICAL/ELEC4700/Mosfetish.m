% By : Jake Tully Student # 100904392
% Date: 2016-01-23

% Mosfet attempt

clear
clc
close all

kb= 1.38064852*(10^-23); %boltzmans constant
m=0.26*(9.10956*10^-31); %electron rest mass
T = 300; %tempature in Kelvin
v = sqrt((kb*T)/(2*m));% calculation of the thermal velocity
V =sqrt((kb*T)/(m));

numatoms=50;
traces = 16;
Volts = 0.8 
me = 0.51099906*10^6
q = 1.60217662*10^-19
E = Volts/(200*10-9);
F = q*E;
a = F/m
MFP = V*(0.2*10^-12);

Xo = 200*rand(numatoms,1);
Yo = 150*rand(numatoms,1);
Xo2 = zeros(numatoms,1);
Yo2 = zeros(numatoms,1);

Vx = randn(numatoms,1)*v ;
Vy = randn(numatoms,1)*v ;

nx=100;                           %Number of steps in space(x)
ny=100;
                          %Number of steps in space(y)       
niter=10000;                      %Number of iterations 
dy=1.5/(nx-1);                     %Width of space step(x)
dx=2/(ny-1);                     %Width of space step(y)
y=0:dy:1.5;                        %Range of x(0,2) and specifying the grid points
x=0:dx:2; 

[X,Y] = meshgrid(x,y)

h=ones(nx,ny);  
a = 1
    for w=(length(x)*0.4)-6:(length(x)*0.4)+6
   h(w,:)=0.000001;
    end
      for w=(length(x)*0.4)+6:length(x)
          
          for r = 1:length(x)
   h(w,r)= a;
   a=a;
          end
          a=a;
      end
x1 = (0.43)*nx:0.83*nx;

Volts =1;
p1=zeros(nx,ny);        %Preallocating p
pn1=zeros(nx,ny);

p1(1,:)=Volts;              

p1(x1,1) = 0.5;
p1(x1,nx)= 0;
pn1 =p1;


i=2:nx-1;
j=2:ny-1;
% potential caculations
for it=1:niter
    pn1=p1;
      
p1(j,i) = ((pn1(i+1,j+1).*h(i+1,j+1)+pn1(i+1,j-1).*h(i+1,j-1)+pn1(i-1,j+1).*h(i-1,j+1)+pn1(i-1,j-1).*h(i-1,j-1)))/4;
    
p1(1,:)=Volts;              

p1(x1,1) = 0.5;
p1(x1,nx)= 0;
end
p1(:,1)=p1(:,2);
p1(:,nx)=p1(:,nx-1);
p1(x1,1) = 0.5;
p1(x1,nx)=0 ;
[Ey ,Ex] =  gradient(p1); 
Ey = - Ey;
Ex = - Ex;
x1 = 5:15:nx-5;
y1 = 5:15:ny-5;
figure(7)
mesh(X,Y,p1)
title({'Potential feild';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')



figure(9)
quiver(X(x1,y1),Y(x1,y1),Ey(x1,y1),Ex(x1,y1))
title({'Electric Field Y';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')


for i=1:length(Xo)
  
    if Yo(i)>50 && Yo(i)<66.66
          
             Yo(i) = Yo(i) +15;
          
    end
                                                %for part 3 only
  
end
  figure(3)
 
  plot(Xo,Yo,'*')

  
  deltaT = 5*10^-6;
time= zeros(numatoms,1);
as=1

xbox = [0 200 0 200];
ybox1 = [ 50  50 60 60];
 
for t=0:deltaT:deltaT*10^3

   fx = q.*Ex;
   fy = q.*Ey;
   ax = (fx./m);
   ay = (fy./m);


     Xo2=Xo;
     Yo2=Yo;
     for j=1:length(Xo)
       xp = ceil(Xo/2);
       yp = ceil(Yo*(3/2));
       
       
       while (sum(xp>100)>0||sum(xp<1)>0||sum(yp>100)>0||sum(yp<1)>0)
       I1 = xp <1;
       I2 = xp> 100;
       xp = xp + I1 -I2;
       
       I3 = yp <1;
       I4 = yp > 100;
       yp = yp + I3 -I4;
       
       end
       
       
     Vx(j) = Vx(j) +  ax(xp(j),yp(j))*deltaT;
     Vy(j) = Vy(j) +  ay(xp(j),yp(j))*deltaT;
     end
 
    
     
         % logic to move particle due to periodic boundary condition in x
     moveleft = (Xo>200)*200;
     moveright = (Xo<0)*200;
     
     for r=1:length(Vx)
         if moveright(r)
     Vx(r) = randn()*v ; 
         end 
     end
     Xo = Xo-moveleft + moveright;
     
     
     hittop = Yo>150;
     hitbot = Yo<0;
     
     hitfet = (Yo>50).*(Yo<63);
     
 Vy = Vy + (-2*Vy.*(Yo<0) -2*Vy.*((Yo>52).*hitfet)) - (2*Vy.*(Yo>100) +2*Vy.*(Yo<60).*hitfet) ; % logic to change direction when
    
      %Vy = Vy - a*deltaT; 
     Xo= Xo+deltaT.*Vx;
     Yo= Yo+deltaT.*Vy;
 figure(3)
  plot(Xo,Yo,'*')
   hold on
  plot(xbox,ybox1,'k')

    hold off
  axis([0 200 0 150])

    Title = sprintf('Simulation of %f atoms Path of %f atoms',numatoms ,traces);
  Xlabel = sprintf('length in nano meters');
  Ylabel = sprintf('width in nano meters');

  PlotTragectory(Xo,Yo,Xo2,Yo2,traces,Title,Xlabel,Ylabel)
    
    
    
    
    
    
end