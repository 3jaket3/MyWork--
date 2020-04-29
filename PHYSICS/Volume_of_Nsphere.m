%{
Volume of a N-Dimensional Sphere

10/13/26 Jake Tully

This Script dart throwing approximation to accurately 
estimate the value of a N-dimensional sphere.

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
R3i = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2 + Mdarts(:,3).^2) <= 1; % 3-D
R4i = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2 + Mdarts(:,3).^2 + Mdarts(:,4).^2) <= 1; % 4-D
R5i = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2 + Mdarts(:,3).^2 + Mdarts(:,4).^2 + Mdarts(:,5).^2) <= 1; % 5-D

% Find Radius && 0 Radius's outside target area
R2 = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2).*R2i;
R3 = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2 + Mdarts(:,3).^2).*R3i;
R4 = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2 + Mdarts(:,3).^2 + Mdarts(:,4).^2).*R4i;
R5 = sqrt( (Mdarts(:,1).^2) + Mdarts(:,2).^2 + Mdarts(:,3).^2 + Mdarts(:,4).^2 + Mdarts(:,5).^2).*R5i;


% remove any zeros
v2 = nonzeros(R2);
v3 = nonzeros(R3);
v4 = nonzeros(R4);
v5 = nonzeros(R5);

% Calculate volume of a N-dimensional sphere
V2 = 4*length(v2)/Ndarts;
V3 = 8*length(v3)/Ndarts;
V4 = 16*length(v4)/Ndarts;
V5 = 32*length(v5)/Ndarts;

fprintf(' the resulting approximations are\n');
fprintf( '  2: %f\n  3: %f\n  4: %f\n  5: %f\n\n', V2,V3,V4,V5);

