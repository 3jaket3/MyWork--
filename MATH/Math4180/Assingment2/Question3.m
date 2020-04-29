%{
    Runge-Kutta-Method for System Of Ordinary Differential Equations

    11/13/2017 Jake Tully

    This script solves a system of ODE's Using RK4 
%}

clear 
clc
close all

f1 = @(x,u1,u2) u2; % initial value
f2 = @(x,u1,u2) -(4*u2)/x - (2*u1)/x^2 + (2*log(x))/x^2;
f3 = @(x) log(x) + 4/x - 2/x^2 -3/2;

a = 1; % initial mesh point
b = 2; % final mesh point
alpha = 0.5; % initial value of the solution
beta = 0;
N = 20;% number of intervals between the mesh points
h = (b-a)/N; % step size
x = a;
w1 = alpha;
w2 = beta;

A = zeros (N+1,3); 
A(1,1) = x; A(1,2) = w1; A(1,3)=w2; 

K1 = [0 0];
K2 = [0 0];
K3 = [0 0];
K4 = [0 0];

for i = 2 :(N+1)
    
  A(i,1) = A(i-1,1) + h ; 
  
  K1(1) = h * f1(A(i-1,1),A(i-1,2),A(i-1,3));
  K1(2) = h * f2(A(i-1,1),A(i-1,2),A(i-1,3));
  
  K2(1) = h * f1(A(i-1,1)+h/2,A(i-1,2)+K1(1)/2,A(i-1,3)+K1(2)/2);
  K2(2) = h * f2(A(i-1,1)+h/2,A(i-1,2)+K1(1)/2,A(i-1,3)+K1(2)/2);
  
  K3(1) = h * f1(A(i-1,1)+h/2,A(i-1,2)+K2(1)/2,A(i-1,3)+K2(2)/2);
  K3(2) = h * f2(A(i-1,1)+h/2,A(i-1,2)+K2(1)/2,A(i-1,3)+K2(2)/2);
  
  K4(1) = h * f1(A(i-1,1)+h,A(i-1,2)+K3(1),A(i-1,3)+K3(2));  
  K4(2) = h * f2(A(i-1,1)+h,A(i-1,2)+K3(1),A(i-1,3)+K3(2));  
  
  A(i,2) = A(i-1,2) + (1/6)*(K1(1)+2*K2(1)+2*K3(1)+K4(1));
  A(i,3) = A(i-1,3) + (1/6)*(K1(2)+2*K2(2)+2*K3(2)+K4(2));
  
end

p1 = @(x,u1,u2) u2; % initial value
p2 = @(x,u1,u2) -(4*u2)/x - (2*u1)/x^2 ;

a = 1; % initial mesh point
b = 2; % final mesh point
alpha = 0; % initial value of the solution
beta = 1;
N = 20;% number of intervals between the mesh points
h = (b-a)/N; % step size
x = a;
w1 = alpha;
w2 = beta;
A1 = zeros (N+1,3); 
exactY = zeros(N+1,1);

A1(1,1) = x; A1(1,2) = w1; A1(1,3)=w2; exactY(1) = f3(1);

for i = 2 :(N+1)
    
  A1(i,1) = A1(i-1,1) + h ; 
  
  K1(1) = h * p1(A1(i-1,1),A1(i-1,2),A1(i-1,3));
  K1(2) = h * p2(A1(i-1,1),A1(i-1,2),A1(i-1,3));
  
  K2(1) = h * p1(A1(i-1,1)+h/2,A1(i-1,2)+K1(1)/2,A1(i-1,3)+K1(2)/2);
  K2(2) = h * p2(A1(i-1,1)+h/2,A1(i-1,2)+K1(1)/2,A1(i-1,3)+K1(2)/2);
  
  K3(1) = h * p1(A1(i-1,1)+h/2,A1(i-1,2)+K2(1)/2,A1(i-1,3)+K2(2)/2);
  K3(2) = h * p2(A1(i-1,1)+h/2,A1(i-1,2)+K2(1)/2,A1(i-1,3)+K2(2)/2);
  
  K4(1) = h * p1(A1(i-1,1)+h,A1(i-1,2)+K3(1),A1(i-1,3)+K3(2));  
  K4(2) = h * p2(A1(i-1,1)+h,A1(i-1,2)+K3(1),A1(i-1,3)+K3(2));  
  
  A1(i,2) = A1(i-1,2) + (1/6)*(K1(1)+2*K2(1)+2*K3(1)+K4(1));
  A1(i,3) = A1(i-1,3) + (1/6)*(K1(2)+2*K2(2)+2*K3(2)+K4(2));
  
  exactY(i,1) = f3(A1(i,1));
end

beta = log(2);

x = A(:,1);
y = A(:,2) + ((beta-A(i,2))/A1(i,2))*A1(:,2);
Z(:,1)=x;
Z(:,2)=y;
Z(:,3)=exactY;
Z(:,4) = abs(y-exactY);

figure(1)
plot(x,y,'r.', x,exactY,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Solution of x');
legend('Approcimate solution' , 'Exact solution', 'location','best');

