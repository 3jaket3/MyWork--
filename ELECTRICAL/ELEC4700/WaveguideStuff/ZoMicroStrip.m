function [ Zo ] = ZoMicroStrip( s, er )
%ZoMicroStrip Summary of this function goes here
%  calculates impedence for  s= w/h

x = 0.56*((er-0.9)/(er+3))^-0.05;
y = 1 + 0.02*log(s^4 + ((3.7*10^-4)*s^2)/(s^4 +0.43)) + 0.05*log(1 + (1.7*10^-4)*s^3);
eff = (er + 1)/2 +((er-1)/2)*(1+10/s)^-x*y;
Zo=  (60/sqrt(eff))* log((6+(2*pi-6)*exp(-(30.67/s)^0.75))/s +sqrt(1+(4/s^2)))  ;



end

