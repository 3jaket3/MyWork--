function [ d ] = Distance_Between_Planes( t )
%{
    Distance_Between_Planes
    
    10/9/2014   Jake Tully

    This function calculates the distance between the 
    two planes traveling at a given time t

%}
x1= 200-400*cosd(30)*(t./60);
y1= 100-400*sind(30)*(t./60);
x2= 100*cos((450*(t/60))/100);
y2= 100*sin((450*(t/60))/100);
d=sqrt((x2-x1).^2+(y2-y1).^2);

end

