clear 
clc

v = 1;
g = 2;
alpha = 0.5;
beta = log(2);
N = 19;
h = (g-v)/(N+1);

p =@(x) -4/x;
q = @(x) -2/x^2;
r = @(x) (2*log(x))/x^2;
 y = @(x) 4/x - 2/x^2 + log(x) -3/2;

 x = v + h;
 a(1) = 2 + (h^2)*q(x);
 b(1) = -1 + (h/2)*p(x);
 d(1) = -(h^2)*r(x) + (1+(h/2)*p(x))*alpha;
 
 for i = 2:N-1
    x = v +i*h;
    a(i) = 2 +(h^2)*q(x);
    b(i) = -1 +(h/2)*p(x);
    c(i) = -1 -(h/2)*p(x);
    d(i) = -(h^2)*r(x);
 end
   x = g-h;
 a(N) = 2 + (h^2)*q(x);
 c(N) = -1 -(h/2)*p(x);
 d(N) = -(h^2)*r(x) + (1 - (h/2)*p(x))*beta;
 
 l(1) = a(1);
 u(1) = b(1)/a(1);
 z(1) = d(1)/l(1);
 
 for i=2:N-1
    l(i) = a(i) - c(i)*u(i-1);
    u(i) = b(i)/l(i);
    z(i) = (d(i) - c(i)*z(i-1))/l(i);
 end
 
 l(N) = a(N) - c(N)*u(N-1);
 z(N) = (d(N) -c(N)*z(N-1))/l(N);
   
   W = zeros(N+2,1);
   X = W;
   Y = W;
   W(1) = alpha;
   W(N+2) = beta;
   W(N+1) = z(N);
   
   
   j = N
   for i = 2:N
    W(j) = z(j-1) -u(j-1)*W(j+1);
    j= j-1;
   end
   
   X(1) = v;
   Y(1) = y(v);
   for i = 2:N+2
    X(i) = X(i-1) + h;
    Y(i) = y(X(i));
   end
   
   
   

   
   A(:,1) = X;
   A(:,2) = W;
   A(:,3) = Y;
   A(:,4) = abs(W-Y);
   
   
   
p =@(x) -4/x;
q = @(x) -2/x^2;
r = @(x) (2*log(x))/x^2;
a = 1;
b = 2;
alpha = 0.5;
beta = log(2);
N = 19;
h = (b-a)/(N+1);

A = zeros(N,N);
x = linspace(1,2,N+2);

for i=1:N A(i,i) = 2 + h^2 * q(x(i+1)); end
for i=1:N-1 A(i,i+1) = -1 +(h/2)*p(x(i+1)); end
for i=2:N A(i,i-1) = -1 - (h/2)*p(x(i+1)); end

b = zeros(N,1);
b(1) = -h^2*r(x(2)) + (1 + (h/2)*p(x(2)))*alpha;
b(N) = -h^2*r(x(N+1)) +(1-(h/2)*p(x(N+1)))*beta;

for i=2:N-1 b(i) =  -h^2*r(x(i+1)); end

w = A\b;

w = [alpha;w;beta];

figure(2)
plot(x,w,x,Y)
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Solution of x');
legend('Approcimate solution' , 'Exact solution', 'location','best');
figure(1)
plot(X,W,X,Y)
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Solution of x');
legend('Approcimate solution' , 'Exact solution', 'location','best');
xlim([1 2])   