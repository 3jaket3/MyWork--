%{ 
    ELECTRON SPIN RESONANCE

    10/12/2016 Jake Tully

    This Srcipt fits the results of an ESR lab using polyfit

%}

clear
clc
close all

F = [57.2970 74.8530 43.5310] ;
B = [1.8071 2.533604 1.434467] ; 
linefit = polyfit( F , B , 1) ; 
f= @(x) linefit(1)*x + linefit(2);
fprintf(' The slope is %f and the y intercept %f\n', linefit(1),linefit(2))

plot( F, B,'*')
hold on
title('linear Regression of the ESR data')
xlabel(' Frequency in MHz ')
ylabel(' Magnitude of magnetic feild in micro Tesla ' )
fplot(f,[0 80],'r')

% ESPR mid

x1 = 1;
xo =57.297;
w1 = @(x) (x1^2/(0.7*(x-xo)^2 +x1^2))*1.807;

figure(2)
hold on
fplot(w1, [35 80],'r')

%ESPR high
xo =74.853;
w1 = @(x) (x1^2/((x-xo)^2 +x1^2))*2.5336;

figure(2)
fplot(w1, [35 80], 'g')

%ESPR low
xo =43.531;
w1 = @(x) (x1^2/((x-xo)^2 +x1^2))*1.434467;

figure(2)
title(' Typical ESR spectrum example ')
xlabel(' Frequency in MHz ')
ylabel(' Magnetic feild strength ' )
fplot(w1, [35 80],'k')

x1 = 1;
xo =57.297;
w1 = @(x) (x1^2/(0.7*(x-xo)^2 +x1^2));

figure(3)
hold on
title(' Typical ESR spectrum example ')
xlabel(' Frequency in MHz ')
ylabel(' Magnetic feild strength  ' )

fplot(w1, [50 70],'r')
