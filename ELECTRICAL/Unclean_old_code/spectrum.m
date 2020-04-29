%spectrum

I1 = 5;
I3 = 2;

l = linspace (-10,10,21);
m = l;
[L,M] = meshgrid(l,m);

Z =  (L.*(L+1))./(2*I1) + M.^2*((1/(2*I3)) - (1/(2*I1)));
figure(1)
mesh(L,M,Z)

I1 = 2000;
Z =  (L.*(L+1))./(2*I1) + M.^2*((1/(2*I3)) - (1/(2*I1)));
figure(2)
mesh(L,M,Z)
