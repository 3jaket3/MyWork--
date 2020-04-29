%{
    Euler's Method II

    10/9/1017 Jake Tully

    This Script is an example of Euler's Method

%}

clear 
clc
close all

a = 1; % initial mesh point
b = 2; % final mesh point
alpha = 0.2; % initial value of the solution
N = 1000% number of intervals between the mesh points
h = (b-a)/N; % step size
t = a;
w = alpha;

A = zeros (N+1,4);
A(1,1) = t; A(1,2) = w; A(1,3)=w;

for i = 2:(N+1)
   A(i,1) = A(i-1,1) + h; % Assomgomg va;ies fpr tje first column of A
   A(i,2) = A(i-1,2) + h * 10 * A(i-1,2); %Assinging values for the 2nd column
   A(i,3) = 0.2*exp(10*(A(i,1)-1)); % assinging values for 3rd column
   A(i,4) = A(i,3) - A(i,2); % assinging values for the 4th column of A
end

r = A(:,1); % Assinging r the first column of A
s1 = A(:,2); % Assinging s1 the second colun of A
s2 = A(:,3); % Assinging s2 the thrid column of A
s3 = A(:,4); % Assinging s3 the forth colun of A

plot(r,s1,'r', r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
legend('Approcimate solution' , 'Exact solution', 'location','best');

