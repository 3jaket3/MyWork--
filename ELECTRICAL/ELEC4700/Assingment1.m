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
v = sqrt((k*T)/m); % calculation of the thermal velocity

numatoms=5;
Xo = 200*rand(numatoms,1)
Yo = 100*rand(numatoms,1);

Vx = (-1 + 2*rand(numatoms,1))*v;

r = randi([0 1],1,numatoms);
for i=1:length(Vx)
   Vy(i) = sqrt(v^2 - Vx(i)^2);  % sum of Vx and Vx must be v and have random direction
    if r(i) == 1
    Vy=-Vy;
    end
end
Vy = transpose(Vy);
vo= sqrt(Vx.^2 + Vy.^2); % check for the correct magnitude of v

theta = atan(Vy./Vx); % angle in x-y plane
plot(Xo,Yo,'*')

Xc=Xo;
Yc=Yo;
l=0;
for t=0:0.000001:0.0001
   
    

    for k=1:numatoms
        
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
    pause(1)


  

   plot(Xo,Yo,'*')
   
      

  
      
      
end

Xc = transpose(Xc);
Yc = transpose(Yc);

figure(2)
plot(Xc,Yc)

