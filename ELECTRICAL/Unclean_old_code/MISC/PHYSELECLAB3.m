function [  ] = PHYSELECLAB3( )
clear 
clc
close all

% Parameters
C = 6.906*10^-8;
Mn = 637.127;
W=350;
L=10;
Vt = 1.67;
Vgs = 4;

%call to function to find drain current
Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );
Vds= 1:1:5;
fprintf('Vds          Id             Vgs       @Vb=0,\n')

% vary vds and see output results
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 4 )
    
end
fprintf('\n\n')


hold on
figure(1)
fplot(Id,[0 5],'r') 

Vgs = 6;

Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );

fprintf('Vds          Id             Vgs          \n')
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 6 )
    
end
fprintf('\n\n')

fplot(Id,[0 5],'r')

Mn = 724.008;
Vt = 3.12;
Vgs = 4;

Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );
Vds= 1:1:5;

fprintf('Vds          Id             Vgs\n')
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 4 )
    
end
fprintf('\n\n')

hold on
fplot(Id,[0 5])

Vgs = 6;

Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );

fprintf('Vds          Id             Vgs\n')
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 6 )
    
end
fprintf('\n\n')

fplot(Id,[0 5])

figure(3)
C = (3.9*(8.854*10^-14))/(200*10^-9);
Mn = 637.127;
W=25;
L=3.5;
Vt = 1.67;
Vgs = 3;

Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );
Vds= 1:1:5;
fprintf('Vds          Id             Vgs\n')
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 4 )
    
end

fprintf('\n\n')
hold on
fplot(Id,[0 5])

Vgs = 5;

Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );
Vds= 1:1:5;
fprintf('Vds          Id             Vgs\n')
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 4 )
    
end

fprintf('\n\n')
hold on
fplot(Id,[0 5])

C = (3.9*(8.854*10^-14))/(200*10^-9);
Mn = 724.008;
W=25;
L=3.5;
Vt = 3.12;
Vgs = 3;


Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );
Vds= 1:1:5;
fprintf('Vds          Id             Vgs\n')
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 4 )
    
end

fprintf('\n\n')
hold on
title('Current Vs Voltage Vds  (-- @Vbs=1) & Vgs = 3 or 5')
xlabel('Voltage Vds')
ylabel('Current')
fplot(Id,[0 5],'r--')

Vgs = 5;

Id=@(Vds) Triode(Mn, C ,W ,L, Vt,Vgs, Vds );
Vds= 1:1:5;
fprintf('Vds          Id             Vgs\n')
for k=1:5
   
    fprintf('%f     %f      %f\n', k,Triode(Mn, C ,W ,L, Vt,Vgs, Vds(k)), 4 )
    
end

fprintf('\n\n')
hold on
fplot(Id,[0 5],'r--')
end

function [ Id ] = Triode(Mn, C ,W ,L, Vt,Vgs, Vds )
Vsat = Vgs-Vt;

if(Vds<Vsat)
Id = Mn*C*(W/L)*(Vds*(Vgs-Vt)-((Vds^2)/2));
end

if(Vds>=Vsat)
    Id= (Mn*C*(W/L)*(((Vgs-Vt)^2)/2));
end


end