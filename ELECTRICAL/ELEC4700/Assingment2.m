% By : Jake Tully Student # 100904392
% Date: 2016-02-27

% Finite diffrence method

%part 1 electrostatic potential problems
% @ x=0, x=L V=Vo fixed at top and bottom
%Tempurature given as 300K 

%Using a simplistic Monte-Carlo model each particle is given a random direction and position then 
%its motion is tracted through the semiconductior device


clear
clc
close all

% Solving the 2-D Poisson equation by the Finite Difference
%Specifying parameters
nx=310;                           %Number of steps in space(x)
ny=310;
                          %Number of steps in space(y)       
niter=5000;                      %Number of iterations 
dx=2/(nx-1);                     %Width of space step(x)
dy=1/(ny-1);                     %Width of space step(y)
x=0:dx:2;                        %Range of x(0,2) and specifying the grid points
y=0:dy:1;                        %Range of y(0,2) and specifying the grid points
b=zeros(nx,ny);                  %Preallocating b
pn=zeros(nx,ny);                 %Preallocating pn
Ex=zeros(nx,ny); 
Ey=zeros(nx,ny); 
Ex1=Ex;
Ey1=Ey;
% Initial Conditions
p=zeros(nx,ny);                  %Preallocating p
p1=zeros(nx,ny);
% Initial Conditions
h=ones(nx,ny);                  %Preallocating p

%Boundary conditions
%Boundary conditions
[X,Y] = meshgrid(x,y);
[L,W] = meshgrid(x,y);
for r=1:(length(x)/2)-100
    for w=(length(x)/2)-50:(length(x)/2)+50
   h(w,r)=0.01;
  
end
    
end
for r=(length(x)/2)+100:length(x)
    for w=(length(x)/2)-50:(length(x)/2)+50
   h(w,r)=0.01;

end
    
end
figure(8)
mesh(X,Y,h)
title('2-D Poisson equation')
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')
p(1,:)=0.3;                  
p(nx,:)=0;
p1(1,:)=0.3;                  
p1(nx,:)=0;
Ex(1,:)=0.3;
Ex(nx,:)=0;
Ey(1,:)=0.3;
Ey(nx,:)=0;

%Source term
b(1,:)=1;                  
b(nx,:)=1;;


i=2:nx-1;
j=2:ny-1;
u= 1:nx-1;
v= 1:ny-1;
%Explicit iterative scheme with C.D in space (5-point difference)
for it=1:niter
    pn=p;
    pn1=p1;
    p(i,j)=((dy^2*(pn(i+1,j)+pn(i-1,j)))+(dx^2*(pn(i,j+1)+pn(i,j-1)))-(b(i,j)*dx^2*dy*2))/(2*(dx^2+dy^2));
    
    p1(j,i) = (pn1(i+1,j+1)+pn1(i+1,j-1)+pn1(i-1,j+1)+pn1(i-1,j-1)-(b(i,j)))/(4);
  
        p1= h.*p1;
    
      pn1=p1;
     p1(j,i) = (pn1(i+1,j+1)+pn1(i+1,j-1)+pn1(i-1,j+1)+pn1(i-1,j-1)-(b(i,j)))/(4);
      
       
    p(1,:)=0.1;                  
    p(nx,:)=0;
      p1(1,:)=0.1;                  
    p1(nx,:)=0;
    
   % figure(3)
   % mesh(L,W,p)
    Ex1=Ex;
    Ey1=Ey;

    Ey(i,j) = (((Ey1(i,j+1)+Ey1(i,j-1)))-(b(i,j)))/(2);
    
    
    Ex(i,j) = (((Ex1(i+1,j)+Ex1(i-1,j)))-(b(i,j)))/(2);
    Ex = Ex.*h;
    Ex1(1,:)=0.3;
    Ex(nx,:)=0;
    Ey1(1,:)=0.3;
    Ey(nx,:)=0;
   
end
J= zeros(nx,ny);

        J= h.*Ex;


%Plotting the solution

figure(3)
mesh(L,W,p)
title({'2-D Poisson equation';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

figure(4)
mesh(L,W,p1)
title({'2-D Poisson equation';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

figure(5)
hv=surf(L,W,p1','EdgeColor','none');       
shading interp
title({'2-D Poisson equation';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

figure(6)
mesh(L,W,Ey)
title({'Electric Field';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

figure(7)
mesh(L,W,Ex)
title({'Electric Field';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')
figure(8)
mesh(L,W,J)
title({'Current density';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')

x= linspace (0,1.5,201);
y= linspace (0,1,201);




l=0;
k=0;
f=0;
conductivity= [1 0.8 0.6 0.4 0.2 0.08 0.06 0.04 0.02];
Current = [50.0481 49.2505 48.4528 47.6551 46.8574 46.378 46.299 46.2193 46.1395];
figure(9)
plot(conductivity,Current)
title ('Coductivity value Vs Current')
xlabel('Conductivity')
ylabel('Current')

MeshLengths = [20 30 40 50 60];
Current = [47.1367 46.4255 46.0996 46.1498 46.5664];
plot(MeshLengths , Current)
xlabel('Mesh Lenghts')
ylabel('Current')


I=(sum(sum(J))*1.5)/nx;
