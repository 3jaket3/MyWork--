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

k= 1.38064852*(10^-23); %boltzmans constant
m=0.26*(9.10956*10^-31); %electron rest mass
T = 300; %tempature in Kelvin
v = sqrt((k*T)/m)% calculation of the thermal velocity
Sdev=sqrt((k*T)/m)
numatoms=4;
Xo = 200*rand(numatoms,1);
Yo = 100*rand(numatoms,1);

Vx = (-1 + 2*rand(numatoms,1))*Sdev + (-1 + 2*rand(numatoms,1))* Sdev^2 ;
Vy = (-1 + 2*rand(numatoms,1))*Sdev + (-1 + 2*rand(numatoms,1))*Sdev^2;

for i=1:length(Vx)
 
    temp(i) = sqrt(Vx(i).^2 + Vy(i).^2);
    
end



average = sum(temp)/numatoms

figure(1)
hist(temp)


 % check for the correct magnitude of v

theta = atan(Vy./Vx); % angle in x-y plane
scatterd=0;

Xc=Xo;
Yc=Yo;
deltaT = 0.000001;
T= zeros(numatoms);
for t=0:deltaT:deltaT*10^2
   
    
    
    
    
    

    for k=1:numatoms
        
        T(k)= T(k) + deltaT;
        Pscat = 1-exp(-T(k)/(20*deltaT) );
        
        if Pscat>0.8
           
            Vx(k) = (-1 + 2*rand(1))*Sdev + (-1 + 2*rand(1))* Sdev^2 ;
            Vy(k) = (-1 + 2*rand(1))*Sdev + (-1 + 2*rand(1))*Sdev^2;
            T(k) = 0;
            scatterd = scatterd +1;
        end    
        
     Xo(k)= Xo(k)+cos(theta(k)).*t.*v;
     Yo(k)= Yo(k)+sin(theta(k)).*t.*v;
       if Xo(k)>200
           Xo(k)=0;
       end                % logic to move particle due to periodic boundary condition in x
       
       if Xo(k)<0
          Xo(k)=200;
       end
       
       if Yo(k)>100
           Vy(k) = -Vy(k);
            Yo(k) = 100;
        theta(k) = atan(Vy(k)./Vx(k));
       end
                                    % logic to change direction when
                                    % hitting y boundary
        if Yo(k)<0
                Vy(k) = -Vy(k);
                Yo(k) = 0;
        theta(k) = atan(Vy(k)./Vx(k));
            
        end
    end
    
     Xc=horzcat(Xc,Xo);     
     Yc=horzcat(Yc,Yo);
 

  figure(2)

   plot(Xo,Yo,'*')
      
end


Xc = transpose(Xc);
Yc = transpose(Yc);
figure(3)
plot(Xc,Yc)
for i=1:length(Vx)
  
    temp(i) = sqrt(Vx(i).^2 + Vy(i).^2);
    
end
average = sum(temp)/numatoms
figure(4)
hist(temp)
