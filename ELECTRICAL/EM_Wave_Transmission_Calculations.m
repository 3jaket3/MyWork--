%{
    Basic 1-D Wave Transmision Caluculations

3/30/2016 Jake Tully

This script calculates the value of the transmission coeficient
for a EM wave changing medium vs the frequency of the wave

%}


clc 
clear all 
close all


% set initial variables
m =0.000001257;
e = 8.85418782*10^-12;
er = 5;
f = linspace(8*(10^9),12*(10^9),1000);
c = 3*10^8;

up = c;

lambda = up./f;

B = 2*pi*f*sqrt(er*m*e);
n1 = sqrt(m/e);
n2 = sqrt(m/(5*e));

l = 0.067;


%/////////////////////////////////////////////////////////////////////
%calculations n=1
%calculate impedance
Zin =  (n2*  ( n1/n2 + 1i*tan(B*l))./ (1 + (n1/n2)*1i*tan(B*l))); 
%calculate gamma
G = (Zin - n1)./(Zin+n1);
%calculate reflection coefficient
Pr = 1 - abs(G).^2;

figure(1)
plot(f,Pr)
title( 'Frequency Vs. |Power Transmision Coeffient|^2    n=1')
xlabel('Frequency  Hz')
ylabel('||Power Transmision Coeffient|^2  Coeffient|^2')


%/////////////////////////////////////////////////////////////////////
%calculations n=2
%calculate impedance
Zin =  (n2*  ( n1/n2 + 1i*tan(B*2*l))./ (1 + (n1/n2)*1i*tan(B*2*l))); 
%calculate gamma
G = (Zin - n1)./(Zin+n1);
%calculate reflection coefficient
Pr = 1 - abs(G).^2;

figure(2)
plot(f,Pr)
title( 'Frequency Vs. |Reflection Coeffient|^2    n=2')
xlabel('Frequency  Hz')
ylabel('|Reflection Coeffient|^2')
l = 0.067;

%/////////////////////////////////////////////////////////////////////
%calculations n=3
%calculate impedance
Zin =  (n2*  ( n1/n2 + 1i*tan(B*3*l))./ (1 + (n1/n2)*1i*tan(B*3*l)));
%calculate gamma
G = (Zin - n1)./(Zin+n1);
%calculate reflection coefficient
Pr = 1 - abs(G).^2;

figure(3)
plot(f,Pr)
title( 'Frequency Vs. |Reflection Coeffient|^2    n=3')
xlabel('Frequency  Hz')
ylabel('||Power Transmision Coeffient|^2  Coeffient|^2')


%/////////////////////////////////////////////////////////////////////
%calculations n=4
%calculate impedance
Zin =  (n2*  ( n1/n2 + 1i*tan(B*3*l))./ (1 + (n1/n2)*1i*tan(B*3*l))); 
%calculate gamma
G = (Zin - n1)./(Zin+n1);
%calculate reflection coefficient
Pr = 1 - abs(G).^2;

figure(4)
plot(f,Pr)
title( 'Frequency Vs. |Reflection Coeffient|^2    n=4')
xlabel('Frequency  Hz')
ylabel('||Power Transmision Coeffient|^2  Coeffient|^2')