function [ d ] = Distance( t )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x1= 200-400*cosd(30)*(t./60);
y1= 100-400*sind(30)*(t./60);
x2= 100*cos((450*(t/60))/100);
y2= 100*sin((450*(t/60))/100);
d=sqrt((x2-x1).^2+(y2-y1).^2);

end

