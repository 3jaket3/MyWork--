

x = linspace(0.1,5,100);
y = linspace(0.1,5,100);

[X,Y] = meshgrid(x,y);

for i=1:100
    for k=1:100
       
        Z(i,k) = (1/x(i))*y(k);
        
    end
end

mesh(X,Y,Z)
 title ('relation of percision time to N')
 