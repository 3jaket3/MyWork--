n=linspace(0:1000);
x=linspace(0:0.0001:10)
y=linspace(0:0.0001:10)
H[x,y] = (1./n.*sinh(n.*pi*B)*.(sinh(n*x*pi)*sin(y*.n*pi)