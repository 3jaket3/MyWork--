%{
Volume of a N-Dimensional Sphere

10/13/26 Jake Tully

This Script uses monte-carlo techniques to use the dart throwing
approximation to accurately estimate the value of a N-dimensional
sphere.

%}


clear 
clc
close all

% initialization of matrix
Ndarts = 100000;


nx = Ndarts;
ny = 5;

Mdarts = ones(Ndarts,ny);


    for i=1:Ndarts
   
        for k=1:ny
       
            Mdarts(i,k) =  2*rand -1;
       
        end    
    end

%Eluclidian distance for radius 
R2i = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2) <= 1; % 2-D

% N=2 calculations
R2 = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2).*R2i;
V2 = nonzeros(pi*R2.^2);
v2 = 4*length(V2)/Ndarts;





