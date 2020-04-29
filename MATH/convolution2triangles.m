%{

4/17/2018 
Jake Tully

This script plots the convolution of two
triangle functions

%}


close all
clear
clc 


figure(1)
hold on
% case 1
t = linspace(-1,0,100);
f =(1/6)*(t+1).^3;
% case 2
t2 = linspace(0,1,100);
f2 =  -t2.^3/2 + t2.^2/2 +t2/2 + 1/6;
% case 3
t3 = linspace(1,2,100);
f3 = t3.^3/2 -(5*t3.^2)/2 + (7.*t3)/2 -5/6;
%case 4 
t4 = linspace(2,3,100);
f4 = -(1/6)*(t4-3).^3;


plot(t,f,t2,f2,t3,f3,t4,f4 )