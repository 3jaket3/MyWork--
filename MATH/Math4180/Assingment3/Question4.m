clear
clc

a = 0;
b = 1;
alpha = 1;
Tmax = 0.3;
m = 10;
N = 3;
h = (b-a)/m;
k = Tmax/N;
lambda = k*alpha/h;

f = @(x) sin(2*pi*x);
g = @(x) 2*pi*sin(2*pi*x);

U = zeros(N+1,m+1);
x = a:h:b;
t = 0:k:Tmax;
U(1,:) = f(x);
U(:,1) = 0;
U(:,m+1) = 0;
for i = 1:m-1
U(2,i+1) = (1-lambda^2)*f((i)*h) + (lambda^2/2)*(f((i+1)*h) + f((i-1)*h)) +k*g((i)*h);
end

for j = 2:N
   for i = 2:m
      
       U(j+1,i) = 2*(1-lambda^2)*U(j,i) + lambda^2*(U(j,i+1)+U(j,i-1)) - U(j-1,i);
       
   end
end


[X,T] = meshgrid(x,t);
Exact = sin(2*pi*X).*(cos(2*pi*T) + sin(2*pi*T));
figure(1)
surf(X,T,U)
figure(2)
surf(X,T,Exact)

error = U- Exact
figure(3)
surf(X,T,error)
