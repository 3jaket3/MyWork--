% Solving the 2-D Poisson equation by the Finite Difference
%Specifying parameters
nx=200;                           %Number of steps in space(x)
ny=200;                           %Number of steps in space(y)       
niter=5000;                      %Number of iterations 
dx=1.5/(nx-1);                     %Width of space step(x)
dy=1/(ny-1);                     %Width of space step(y)
x=0:dx:1.5;                        %Range of x(0,2) and specifying the grid points
y=0:dy:1;                        %Range of y(0,2) and specifying the grid points
u=zeros(nx,ny);                  %Preallocating b
pn=zeros(nx,ny);                 %Preallocating pn


% Initial Conditions
h=zeros(nx,ny);                  %Preallocating p


%Boundary conditions

h(1,:)=1;                  
h(nx,:)=1;
for r=1:(length(x)/2)-30
    h((length(x)/2)-30,r)=0;
    h((length(x)/2)+30,r)=0;
end
for r=(length(x)/2)+30:length(x)
    h((length(x)/2)-30,r)=0;
    h((length(x)/2)+30,r)=0;
end
for r=(length(x)/2)-30:(length(x)/2)+30
   h(r,(length(x)/2)+30)=1;
   h(r,(length(x)/2)-30)=1;
   h(r,(length(x)/2)+31)=0;
   h(r,(length(x)/2)-29)=0;
end

%Source term
u(ny,1)=0;
u(ny,1)=0;

[L,W] = meshgrid(x,y);

i=2:nx-1;
j=2:ny-1;
%Explicit iterative scheme with C.D in space (5-point difference)
for it=1:niter
    pn=h;
    h(i,j)=((dy^2*(pn(i+1,j)+pn(i-1,j)))+(dx^2*(pn(i,j+1)+pn(i,j-1)))-(u(i,j)*dx^2*dy*2))/(2*(dx^2+dy^2));
    %Boundary conditions 
    
for r=1:(length(x)/2)-30
    h((length(x)/2)-30,r)=1;
    h((length(x)/2)+30,r)=1;
end
for r=(length(x)/2)+30:length(x)
    h((length(x)/2)-30,r)=1;
    h((length(x)/2)+30,r)=1;
end
for r=(length(x)/2)-30:(length(x)/2)+30
   h(r,(length(x)/2)+30)=1;
   h(r,(length(x)/2)-30)=1;
   h(r,(length(x)/2)+31)=0;
   h(r,(length(x)/2)-31)=0;
end
figure(5)
mesh(L,W,h)
end

%Plotting the solution

figure(5)
mesh(L,W,h)
title({'2-D Poisson equation';['{\itNumber of iterations} = ',num2str(it)]})
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (P) \rightarrow')