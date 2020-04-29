 alpha = 1;
a = 0;
b = 1;
m = 10;
N = 50;
Tmax = 0.5;
h = (b-a)/m;
k = Tmax / N;
lambda = (alpha^2 * k)/h^2;

A = zeros(m-1,m-1);
B = zeros(m-1,m-1);


for i = 1:m-2 A(i,i+1) = -lambda/2; end
for i = 1:m-1 A(i,i) = 1 + lambda; end
for i = 2:m-1 A(i,i-1) = -lambda/2; end

for i = 1:m-2 B(i,i+1) = lambda/2; end
for i = 1:m-1 B(i,i) = 1 - lambda; end
for i = 2:m-1 B(i,i-1) = lambda/2; end

x = a:h:b;
w0 = sin(pi*x);
w0(length(x)) = 0;
w0(1) = 0;
w0 = transpose(w0);
C = A^(-1);

Estimates = zeros(N+1,m-1);
for i=1:N+1
    Estimates(i,:) = C^(i-1)*B^(i-1)*w0(2:length(w0)-1); end

Estimates = [zeros(N+1,1) Estimates zeros(N+1,1)];

t = 0:k:Tmax;

[X,T] = meshgrid(x,t)

surf(X,T,Estimates)


ActualSolution = exp(-pi^2*T).*sin(pi*X);

figure(2)
surf(X,T,ActualSolution)


 d =ActualSolution - Estimates
 
 figure(3)
 surf(X,T,d)