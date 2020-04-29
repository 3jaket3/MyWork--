clear
clc

a = 0 ;
b = 1 ;
c = 0 ;
d = 1 ;
f = @(x,y) 0;
x = linspace(a,b,20);
y = linspace(c,d,20);
h = x(2) -x(1);
U = zeros(length(x),length(y));

U(1,:) = 4*x;

for p = 1: 500
for i = 2: length(x)-1
   
      
    
       
       
       U(i,:) = (U(i+1,:) + U(i-1,:))/2 
       
       
   end
    
end



[X,Y] = meshgrid(x,y);

mesh(X,Y,U)

    
 Ux = zeros(length(x),length(y));
 Uy = zeros(length(x),length(y));
 
 Ux(:,length(x)) = (U(:,length(x))-U(:,length(x)-1))/h;
 Uy(length(y),:) = (U(length(y),:)-U(length(y)-1,:))/h;
 
 for i = 1 : length(x)-1
    
 Ux(:,i) = (-U(:,i)+U(:,i+1))/h;
 Uy(i,:) = (-U(i,:)+U(i+1,:))/h;
     
 end

U1 = -(Ux + Uy)

figure(2)
mesh(X,Y,U1)