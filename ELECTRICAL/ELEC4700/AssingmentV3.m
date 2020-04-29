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
V =sqrt((kb*T)/(m))
numatoms=2000;
traces = 10;

MFP = V*(0.2*10^-12);

Xo = 200*rand(numatoms,1);
Yo = 100*rand(numatoms,1);
Xo2 = zeros(numatoms,1);
Yo2 = zeros(numatoms,1);

Vx = randn(numatoms,1)*v ;
Vy = randn(numatoms,1)*v ;
average = mean(sqrt(Vx.^2 + Vy.^2))
averageVx = mean(abs(Vx));
averageVy = mean(abs(Vy));
fprintf(' At T=0\n The average value of Vx is %f m/s. \n The average value of Vy is %f m/s.\n The mean velocity is %f m/s.\n' , averageVx, averageVy,v)
fprintf(' The mean free path %0.10f \n' , MFP)


figure(1)
subplot(2,1,1)
hist(Vx)
title('Initial Velocity distributions In X-direction')
xlabel('Velocity in (m/s)')
ylabel('Bin count')
subplot(2,1,2)
hist(Vy)
title('Initial Velocity distributions in Y-direction')
xlabel('Velocity in (m/s)')
ylabel('Bin count')
Z=zeros(length(Xo),1);


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



figure(2)
plot(Xo,Yo,'*')
title('Initial electron distribution')
xlabel('length in nano meters')
ylabel('width in nano meters')

 % check for the correct magnitude of v
scatterd=0;
deltaT = 10^-5;
time= zeros(numatoms,1);

for t=0:deltaT:deltaT*10^3

    
     Xo2=Xo;
     Yo2=Yo;
    
     Xo= Xo+deltaT.*Vx;
     Yo= Yo+deltaT.*Vy;
     
     % logic to move particle due to periodic boundary condition in x
     moveleft = (Xo>200)*200;
     moveright = (Xo<0)*200;
     Xo = Xo-moveleft + moveright;

     hittop = Yo>100;
     hitbot = Yo<0;
     %specular
     %Vy = Vy + (-2*Vy.*(Yo<0)) - (2*Vy.*(Yo>100)) ; % logic to change direction when
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
    %{
    Vy = Vy + (-2*Vy.*(fromtop)) - (2*Vy.*(frombottom));
    Vx = Vx + (-2*Vx.*(fromright)) - (2*Vx.*(fromleft));
%}
    %diffusive
    
    Vy = Vy + (-Vy.*(fromtop)) - (Vy.*(frombottom))   +abs(randn(numatoms,1))*v.*fromtop - abs(randn(numatoms,1))*v.*frombottom;
    Vx = Vx + (-Vx.*(fromright)) - (Vx.*(fromleft))   +abs(randn(numatoms,1))*v.*fromright - abs(randn(numatoms,1))*v.*fromleft;

                                     
                                     
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
    
   
   

  Title = sprintf('Simulation of %f atoms Path of %f atoms, number scatterd = %f',numatoms ,traces,scatterd);
  Xlabel = sprintf('length in nano meters');
  Ylabel = sprintf('width in nano meters');

  figure(3)
  plot(Xo,Yo,'*')
  axis([0 200 0 100])
  
  
  PlotTragectory(Xo,Yo,Xo2,Yo2,traces,Title,Xlabel,Ylabel)
                                     
                                       
        Tempature = (m*(Vx.^2 + Vy.^2))/kb;
        
      
  figure(7)
    axis([0 200 0 100])
  scatter3(Xo,Yo,Z,ones(1,numatoms)*100,Tempature,'fill')
   
  colorbar
  view(0,90)
end


averageVx = mean(abs(Vx));
averageVy = mean(abs(Vy));
fprintf('At end\n The average value of Vx is %f m/s. \n The average value of Vy is %f m/s.\n The mean velocity is %f m/s.\n' , averageVx, averageVy,v)
fprintf(' The average Temperature is %f', mean(Tempature))

figure(5)
subplot(2,1,1)
hist(Vx)
title('Initial Velocity distributions In X-direction')
xlabel('Velocity in (m/s)')
ylabel('Bin count')
subplot(2,1,2)
hist(Vy)
title('Initial Velocity distributions in Y-direction')
xlabel('Velocity in (m/s)')
ylabel('Bin count')

