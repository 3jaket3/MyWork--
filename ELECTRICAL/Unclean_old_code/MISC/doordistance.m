function [ D ] = doordistance( A,B,t )
%takes an imput of door sizes and outputs the distance between them as a
%funtion of time
% the doors are asuumed to swing open at a rate of 2degrees per second
%there must be two doors



w=2.*t;
x=A*cosd(w);
y=A*sind(w);
x1=((A+B)-B*cosd(w));
y1=(B*sind(w));
D=sqrt((y1-y)^2+(x1-x)^2);


end

