% unit test
% testing the simpsons function
grid  = 3001 

x = linspace(0, 2*pi, grid);
y = linspace (0, 2*pi,grid);

[X,Y] = meshgrid(x,y);

f = @(x,y) cos(x).*sin(y);

Z = f(X,Y);

mesh(X,Y,Z)

Int = simpson2d(Z,0,pi/2,0,2*pi)
