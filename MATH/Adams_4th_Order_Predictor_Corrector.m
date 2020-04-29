%{
    Adams Fourth order predictor corrector

    10/9/1017 Jake Tully

    This Script is an example of the Adams Fourth order predictor corrector
%}

clear 
clc
close all

% Functions & Initial value
f1 = @(t,y) t/2 - y/2;
f2 = @(t) t-2+3*exp(-t/2);

a = 0;
b = 3;
alpha = 1;

t = a;
w = alpha;
N = 30;
h = (b-a)/N;

A = zeros(N+1,4);
A(1,1) = t; A(1,2) = w; A(1,3) = w; A(1,4) = w; 

% row 1 ti | row 2 yi | row 3 predicted wi | row 4 corrected wi | row 5
% |yi-wi|

for i = 2:4 % claculation of first values needed for perdictor corrector
    % done with RK4
   A(i,1) = A(i-1,1) + h ;
   
   K1 = h*f1(A(i-1,1),A(i-1,3));
   K2 = h*f1(A(i-1)+h/2,A(i-1,3)+K1/2);
   K3 = h*f1(A(i-1,1)+h/2,A(i-1,3)+K2/2);
   K4 = h*f1(A(i-1,1)+h,A(i-1,3)+K3);
   
   A(i,3) = A(i-1,3) + (K1 + 2*K2 + 2*K3 + K4)/6;
   A(i,4) = A(i-1,3) + (K1 + 2*K2 + 2*K3 + K4)/6;
   A(i,2) = f2(A(i,1));
   A(i,5) = A(i,2) - A(i,3);
   
end

for i = 5 :(N+1) % application of predictor corrector
    
     A(i,1) = A(i-1,1) + h ;
     A(i,3) = A(i-1,3) + h*( 55*f1(A(i-1,1),A(i-1,3)) -  59*f1(A(i-2,1),A(i-2,3)) + 37*f1(A(i-3,1),A(i-3,3)) - 9*f1(A(i-4,1),A(i-4,3)))/24;
     A(i,4) = A(i-1,3) + h*( 9*f1(A(i,1),A(i,3)) +  19*f1(A(i-1,1),A(i-1,3)) - 5*f1(A(i-2,1),A(i-2,3)) + f1(A(i-3,1),A(i-3,3)))/24;
     A(i,2) = f2(A(i,1));
     A(i,5) = A(i,2) - A(i,3);
     
end

r = A(:,1); % Assinging r the first column of A
s1 = A(:,4); % Assinging s1 the second colun of A
s2 = A(:,2); % Assinging s2 the thrid column of A
s3 = A(:,5); % Assinging s3 the forth colun of A

figure(1)
plot(r,s1,'r',r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Adams Fourth order predictor corrector');
legend('Approcimate solution' , 'Exact solution', 'location','best');


