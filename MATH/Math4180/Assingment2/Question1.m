%{
    Runge-Kutta-Method for System Of Ordinary Differential Equations

    11/13/2017 Jake Tully

    This script solves a system of ODE's Using RK4 
%}

clear 
clc
close all

f1 = @(t,u1,u2) u2; 
f2 = @(t,u1,u2) (-3*t -t*u2+4*u1)/t^2;

f3 = @(t) 2*t^2 +t + 1/t^2;
f4 = @(t) 4*t+1-2/t^3;

a = 1; % initial mesh point
b = 3; % final mesh point
alpha = 4; % initial value of the solution
beta = 3;
N = 10;% number of intervals between the mesh points
h = (b-a)/N; % step size
t = a;
w1 = alpha;
w2 = beta;
A = zeros (N+1,7); 

A(1,1) = t; A(1,2) = w1; A(1,3)=w2; A(1,4) = w1; A(1,5) = w2;

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
  
  A(i,4) = f3(A(i,1));
  A(i,5) = f4(A(i,1));
  
  A(i,6) = abs(A(i,2) - A(i,4));
  A(i,7) = abs(A(i,3) - A(i,5));
 
end

r = A(:,1); % Assinging r the first column of A
s1 = A(:,2); % Assinging s1 the second colun of A
s2 = A(:,4); % Assinging s2 the thrid column of A

figure(1)
plot(r,s1,'r.', r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Solution of x');
legend('approximate solution' , 'Exact solution', 'location','best');

r = A(:,1); % Assinging r the first column of A
s1 = A(:,3); % Assinging s1 the second colun of A
s2 = A(:,5); % Assinging s2 the thrid column of A

figure(2)
plot(r,s1,'r.', r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Solution of y');
legend('approximate solution' , 'Exact solution', 'location','best');


