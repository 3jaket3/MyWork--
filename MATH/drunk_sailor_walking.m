% The Drunnkin sailor walkin\

%{
9/10/2016 Jake Tully

This script is a basic random simulation

%}



clear 
clc
close all

%Initialize values
x = 0;
y = 0;

sizeX = 1000;
sizeY = sizeX;

X = linspace(0,0,sizeX);
Y = linspace(0,0,sizeY);

maxStrideLength = 2;

% Take X number of random steps
for steps = 1 : sizeX
    
    X(steps) = x ;
    Y(steps) = y ;
    phi = rand() * 2*pi;
    x1 = cos(phi) * maxStrideLength*rand();
    y1 = sin(phi) * maxStrideLength*rand();
    
    x = x +x1;
    y = y +y1;
    

end

plot ( X, Y)


%{

Repeated enough times and averaged
shows that the drunk sailor walking 
travels no distance on average

%}


