%{
    Basic Numerical Methods
    for diffrential equations

    jake tully 9/16/2017

    This script provides examples of euler's method
    and Huen's method

%}


% Eulers Method
clear 
clc
f1 = @(x) -2*x^3 + 12*x^2 -20*x +8.5; % initial value
f2 = @(x) -0.5*x^4 + 4*x^3 - 10*x^2 + 8.5*x +1;
a = 0; % initial mesh point
b = 4; % final mesh point
alpha = 1; % initial value of the solution
N = 8;% number of intervals between the mesh points
h = (b-a)/N; % step size
t = a;
w = alpha;

A = zeros (N+1,4); % creatingg the zeros ,etrox pf soze N+1 by 4 where...
                    % the first column is for the mesh points , the second
                    % colum is for the approcimate value, the thrird column
                    % is for the exact values and the forth column is for
                    % the errror
A(1,1) = t; A(1,2) = w; A(1,3)=w;

for i = 2:(N+1)
   A(i,1) = A(i-1,1) + h; % Assigning values for the first column of A
   A(i,2) = A(i-1,2) + h * f1(A(i-1,1)); %Assinging values for the 2nd column
   A(i,3) = f2(A(i,1)); % assign = zeros (N+1,4);
   A(i,4) = abs(A(i,3) - A(i,2));

end

A % displaying A in the command window
r = A(:,1); % Assinging r the first column of A
s1 = A(:,2); % Assinging s1 the second colun of A
s2 = A(:,3); % Assinging s2 the thrid column of A
s3 = A(:,4); % Assinging s3 the forth colun of A

figure(1)

plot(r,s1,'r', r,s2,'b')
title('Eulers Method step size = 0.25');
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
legend('Approcimate solution' , 'Exact solution', 'location','best');

N = 16;% number of intervals between the mesh points
h = (b-a)/N; % step size
t = a;
w = alpha;

A = zeros (N+1,4); % creatomg tje zerps ,etrox pf soze N+1 by 4 where...
                    % the first column is for the mesh points , the second
                    % colum is for the approcimate value, the thrird column
                    % is for the exact values and the forth column is for
                    % the errror
A(1,1) = t; A(1,2) = w; A(1,3)=w;

for i = 2:(N+1)
   A(i,1) = A(i-1,1) + h; % Assomgomg va;ies fpr tje first column of A
   A(i,2) = A(i-1,2) + h * f1(A(i-1,1)); %Assinging values for the 2nd column
   A(i,3) = f2(A(i,1)); % assA1 = zeros (N+1,4);
   A(i,4) = abs(A(i,3) - A(i,2));

end

r1 = A(:,1); % Assinging r the first column of A
s3 = A(:,2);
plot(r,s1,'r', r,s2,'b',r1,s3,'g')
title('Eulers Method step size = 0.25 and 0.5');
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
legend('Approcimate solution 0.5' , 'Exact solution','Approcimate solution 0.25' );


% Runge kutta method
N = 8;% number of intervals between the mesh points
h = (b-a)/N; % step size
t = a;
w = alpha;
A1 = zeros (N+1,4);
A1(1,1) = t; A1(1,2) = w; A1(1,3)=w;

for i = 2 :(N+1)
  A1(i,1) = A1(i-1,1) + h ; % Assomgomg va;ies fpr tje first column of A1  
  F1 = h * f1(A1(i-1,1));
  F2 = h * f1(A1(i-1,1)+ h/2);
  F3 = h * f1(A1(i-1,1) +h/2);
  F4 = h * f1(A1(i-1,1) +h);  
  A1(i,2) = A1(i-1,2) + (1/6)*(F1+2*F2+2*F3+F4);
  A1(i,3) = f2(A1(i,1)); % assinging values for 3rd column
   A1(i,4) = abs(A1(i,3) - A1(i,2)); % assinging values for the 4th column of A
end

r = A1(:,1); % Assinging r the first column of A
s1 = A1(:,2); % Assinging s1 the second colun of A
s2 = A1(:,3); % Assinging s2 the thrid column of A
s3 = A1(:,4); % Assinging s3 the forth colun of A
figure(2)
plot(r,s1,'r', r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Runge-kutta method order 4');
legend('Approcimate solution' , 'Exact solution', 'location','best');

%Huens method

A = zeros (N+1,4);
A2 = zeros (N+1,4);
A2(1,1) = t; A2(1,2) = w; A2(1,3)=w;

for i = 2 :(N+1)
  A2(i,1) = A1(i-1,1) + h ; % Assomgomg va;ies fpr tje first column of A1  
  A2(i,2) = A1(i-1,2) + (h/4)*(f1(A2(i-1,1)) +3*(f1(A2(i-1,1)+2*h/3)));
  % using wi+1 =
  % wi+(h/4)*(f(ti,wi)+3*f(ti+2*h/3,wi+2*h/3f(ti+h/3,wi+h/3f(ti,wi)))))
  % since no y in equation simplifies
  A2(i,3) = f2(A1(i,1)); % assinging values for 3rd column
   A2(i,4) = abs(A2(i,3) - A2(i,2)); % assinging values for the 4th column of A
end

r = A2(:,1); % Assinging r the first column of A
s1 = A2(:,2); % Assinging s1 the second colun of A
s2 = A2(:,3); % Assinging s2 the thrid column of A
s3 = A2(:,4); % Assinging s3 the forth colun of A

figure(3)
plot(r,s1,'r', r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Huens method order 3');
legend('Approcimate solution' , 'Exact solution', 'location','best');