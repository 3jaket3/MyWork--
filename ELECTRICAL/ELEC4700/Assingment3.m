% By : Jake Tully Student # 100904392
% Date: 2016-01-23

% Modeling Drift Current In a Semiconductor

%Effextive mass of Electrons mn = 0.26mo
%Region size of 200nm x 100nm
%Tempurature given as 300K 

%Using a simplistic Monte-Carlo model each particle is given a random direction and position then 
%its motion is tracted through the semiconductior device


clear
clc
close all

kb= 1.38064852*(10^-23); %boltzmans constant
m=0.26*(9.10956*10^-31); %electron rest mass
T = 300; %tempature in Kelvin
v = sqrt((kb*T)/(2*m));% calculation of the thermal velocity
V =sqrt((kb*T)/(m));

numatoms=1000;
traces = 16;
Volts = 0.8 
me = 0.51099906*10^6
q = 1.60217662*10^-19
E = Volts/(200*10-9);
F = q*E;
a = F/m
MFP = V*(0.2*10^-12);

Xo = 200*rand(numatoms,1);
Yo = 100*rand(numatoms,1);
Xo2 = zeros(numatoms,1);
Yo2 = zeros(numatoms,1);

Vx = randn(numatoms,1)*v ;
Vy = randn(numatoms,1)*v ;

nx=100;                           %Number of steps in space(x)
ny=100;
                          %Number of steps in space(y)       
niter=5000;                      %Number of iterations 
dy=2/(nx-1);                     %Width of space step(x)
dx=1/(ny-1);                     %Width of space step(y)
y=0:dy:2;                        %Range of x(0,2) and specifying the grid points
x=0:dx:1;                        %Range of y(0,2) and specifying the grid points
             %Preallocating pn

xbox = [80 80 120 120];
ybox1 = [0 40 40 0];
ybox2 = [100 60 60 100];
for i=1:length(Vx)
  
    if Xo(i)>80 && Xo(i)<120 &&  Yo(i)<40  
        
            if Xo(i)>80 && Xo(i)<100
        
                Xo(i) = Xo(i) -40 - 20*rand(1);
            end
        
            if Xo(i)<120 && Xo(i)>100
          
                Xo(i) = Xo(i) +40 + 20*rand(1);
            end
    end
                                                %for part 3 only
    if Xo(i)>80 && Xo(i)<120 &&  Yo(i)>60  
        
           if Xo(i)>80 && Xo(i)<100
          
              Xo(i) = Xo(i) -40 - 20*rand(1);
           end
        
           if Xo(i)<120 && Xo(i)>100
          
              Xo(i) = Xo(i) +40 + 20*rand(1);
          end
    end
end
h=ones(nx,ny);  
for r=1:(length(x)/2)-10
    for w=(length(x)/2)-10:(length(x)/2)+10
   h(w,r)=0.0001;
  
end
    
end
for r=(length(x)/2)+10:length(x)
    for w=(length(x)/2)-10:(length(x)/2)+10
   h(w,r)=0.0001;

end
    
end


Volts =0.8;
p1=zeros(nx,ny);        %Preallocating p
pn1=zeros(nx,ny);

% Initial Conditions

                %Preallocating p

%Boundary conditions
%Boundary conditions
[X,Y] = meshgrid(x,y);
[L,W] = meshgrid(x,y);

p1(:,1)=0;                  
p1(:,nx)=0;
pn1(:,1)=0;                  
pn1(:,nx)=0;;

p1(1,:)=Volts;               
p1(nx,:)=0;
pn1(1,:)=Volts;                  
pn1(nx,:)=0;
E=p1;





%density mapping
points = 30;
X1 = linspace(0,200,points);
Y1 = linspace(0,100,points);
[X1,Y1] = meshgrid(X1,Y1);
plot(Xo,Yo,'*')
  lk =  points/200;
  wk = points/100;
for B= 1:points
    for A = 1:points
        I1 = Xo<(B/lk);
        I2 = Xo>((B-1)/lk);
        I3 = Yo<(A/wk);
        I4 = Yo>((A-1)/wk);
        
        Z(A,B) = sum(I1.*I2.*I3.*I4 );
        
    
    end 
end

figure(1)
title('Aprior Electron density map')
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')
mesh(X1,Y1,Z)




current = 0;
  

 % check for the correct magnitude of v
scatterd=0;
deltaT = 2.5*10^-6;
time= zeros(numatoms,1);
as=1


 
for t=0:deltaT:deltaT*10^3
averageVx = mean(abs(Vx));
averageVy = mean(abs(Vy));
T1(as) = (sqrt(averageVx^2 + averageVy^2)^2*m)/kb;
t1(as) = t;
v1(as) = Volts - Volts*exp(-t/0.00005);
as= as+1;

i=2:nx-1;
j=2:ny-1;
% potential caculations
for it=1:niter
    pn1=p1;
      
 p1(j,i) = ((pn1(i+1,j+1).*h(i+1,j+1)+pn1(i+1,j-1).*h(i+1,j-1)+pn1(i-1,j+1).*h(i-1,j+1)+pn1(i-1,j-1).*h(i-1,j-1)))/4;
    
  p1(:,1)=0;                  
 p1(:,nx)=0;         
 p1(1,:)=Volts; 
 p1(nx,:)=0;  
end

 [Ey ,Ex] = gradient(p1);    
 Ex(:,1)=0;                  
Ex(:,nx)=0;
Ey(:,1)=0;                  
Ey(:,nx)=0;;

Ex(1,:)=0;                  
Ex(nx,:)=0;
Ey(1,:)=0;                  
Ey(nx,:)=0;



 n = 1:5:nx;
  n1 = 1:5:(nx/2);
   n2 = (55):5:nx;
   
   a= zeros(length(n),1);
b =ones(length(n),1);
c = transpose(linspace(0,1,length(n)));
color= [a b c];
   
 ex = Ex(n1,n);
 ey = Ey(n1,n);
 l = L(n1,n);
 w = W(n1,n);
 

 ex1 = Ex(n2,n);
 ey1 = Ey(n2,n);
 l1 = L(n2,n);
 w1 = W(n2,n);
 
fx = q.*Ex;
fy = q.*Ey;
ax = (fx./m);
ay = (fy./m);


     Xo2=Xo;
     Yo2=Yo;
     for j=1:length(Xo)
       xp = ceil(Xo/2);
       yp = ceil(Yo);
       
       
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
      %Vy = Vy - a*deltaT; 
     Xo= Xo+deltaT.*Vx;
     Yo= Yo+deltaT.*Vy;
     
     
     % logic to move particle due to periodic boundary condition in x
     moveleft = (Xo>200)*200;
     moveright = (Xo<0)*200;
     current = current + sum(moveright);
     for r=1:length(Vx)
         if moveright(r)
     Vx(r) = randn()*v ; 
         end 
     end
     Xo = Xo-moveleft + moveright;
     
     hittop = Yo>100;
     hitbot = Yo<0;
     %specular
     Vy = Vy + (-2*Vy.*(Yo<0)) - (2*Vy.*(Yo>100)) ; % logic to change direction when
                                     % hitting y boundary
     %diffusive
     
        Vy = Vy + (-Vy.*hitbot) - (Vy.*hittop)  ;
        Vy = Vy + abs(randn(numatoms,1)*v.*(hitbot)) - abs(randn(numatoms,1)*v.*(hittop)) ;
                                     
     %logic for reflecting at boundaries of box
    inbox1 = ((Xo>80) - (Xo>120)).*(Yo<40);
    inbox2 = ((Xo>80) - (Xo>120)).*(Yo>60);
    
    fromleft = inbox1.*(Xo2<80) + inbox2.*(Xo2<80);
    fromright = inbox1.*(Xo2>120) + inbox2.*(Xo2>120);
                                                            %for part 3 only
    frombottom =  inbox2.*((Xo2>80) - (Xo2>120));
    fromtop = inbox1.*((Xo2>80) - (Xo2>120));
    
    %specular
   
   % Vy = Vy + (-2*Vy.*(fromtop)) - (2*Vy.*(frombottom));
    %Vx = Vx + (-2*Vx.*(fromright)) - (2*Vx.*(fromleft));
  
    %diffusive
    
    Vy = Vy + (-Vy.*(fromtop)) - (Vy.*(frombottom))   +abs(randn(numatoms,1))*v.*fromtop - abs(randn(numatoms,1))*v.*frombottom;
    Vx = Vx + (-Vx.*(fromright)) - (Vx.*(fromleft))   +abs(randn(numatoms,1))*v.*fromright - abs(randn(numatoms,1))*v.*fromleft;
 
                                 
               %{                    
    for k=1:numatoms
        
       if inbox1(k)==0 && inbox2(k) == 0       %for part 3 only
     
     
       time(k)= time(k) + (deltaT);
        Pscat = 1-exp(-time(k)/(2*10^-4) );
       
        if Pscat>(4*rand())
           
          Vx(k) = randn()*v ;               %for part 2&3
          Vy(k) = randn()*v ;
            time(k) = 0;
            scatterd = scatterd +1;
        end    
   
       end    %for part 3 only
     
    
                
    end
  
   
   %}

  Title = sprintf('Simulation of %f atoms Path of %f atoms, number scatterd = %f',numatoms ,traces,scatterd);
  Xlabel = sprintf('length in nano meters');
  Ylabel = sprintf('width in nano meters');

  figure(3)
 
  plot(Xo,Yo,'*')
   hold on
  plot(xbox,ybox1,'k')
  plot(xbox,ybox2,'k')
    hold off
  axis([0 200 0 100])

  
  PlotTragectory(Xo,Yo,Xo2,Yo2,traces,Title,Xlabel,Ylabel)
                                     
                                       
   
end
coulomb = 6.238792*10^18;
current = current/(coulomb*(t*10^-9));

figure(4)
quiver(l,w,ey,ex)
title('Vector plot left of bottleneck ')
xlabel('{\leftarrow} Spatial co-ordinate (y)')
ylabel('Spatial co-ordinate (x) \rightarrow')
zlabel('Solution profile (P) \rightarrow')


figure(5)
quiver(l1,w1,ey1,ex1)
title('Vector plot Right of bottleneck')
xlabel('{\leftarrow} Spatial co-ordinate (y)')
ylabel('Spatial co-ordinate (x) \rightarrow')
zlabel('Solution profile (P) \rightarrow')


figure(6)
mesh(L,W,h)
title('Conductivity mesh')
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

figure(7)
mesh(L,W,p1)
title({'Potential feild';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

figure(8)
mesh(L,W,Ex)
title({'Electric Field X';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

figure(9)
mesh(L,W,Ey)
title({'Electric Field Y';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

%density mapping
points = 30;
X1 = linspace(0,200,points);
Y1 = linspace(0,100,points);
[X1,Y1] = meshgrid(X1,Y1);
plot(Xo,Yo,'*')
  lk =  points/200;
  wk = points/100;
for B= 1:points
    for A = 1:points
        I1 = Xo<(B/lk);
        I2 = Xo>((B-1)/lk);
        I3 = Yo<(A/wk);
        I4 = Yo>((A-1)/wk);
        
        Z(A,B) = sum(I1.*I2.*I3.*I4 );
        
    
    end 
end

figure(10)
title('final Electron density map')
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')
mesh(X1,Y1,Z)

figure(11)
plot(t1,T1)
title('Tempature Vs Time')
xlabel('Time')
ylabel('Tempature(K)')

figure(12)
plot(t1,v1)
title('Voltage Vs Time')
xlabel('Time')
ylabel('Volts')


averageVx = mean(abs(Vx));
averageVy = mean(abs(Vy));


figure(13)
subplot(2,1,1)
hist(Vx)
title('Final Velocity distributions In X-direction')
xlabel('Velocity in (m/s)')
ylabel('Bin count')
subplot(2,1,2)
hist(Vy)
title('Final Velocity distributions in Y-direction')
xlabel('Velocity in (m/s)')
ylabel('Bin count')


