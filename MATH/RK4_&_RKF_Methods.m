%{
    Runge-Kutta-Felhberg Method

    10/9/1017 Jake Tully

    This Script is an example of the Runge-Kutta-Felhberg Method
    & Runge-Kutta 4th Order

%}

clear 
clc
close all


%/////////////////////////////////////////////////////////////////////////
%   Runge-Kutta- 4th-Order

f1 = @(y) 1 +y^2; % function 1
f2 = @(t) tan(t); % function 2

% initial Values
a = 0;
b = 1.4;
alpha = 0;

t = a;
w = alpha;
N = 14;
h = (b-a)/N;

A = zeros(N+1,4);
A(1,1) = t; A(1,2) = w; A(1,3) = w; 
% row 1 ti | row 2 yi | row 3 predicted wi | row 4 corrected wi | row 5
% |yi-wi|

% loop iteration over number of divisions applying RKF-method
for i = 2:(N+1)
   A(i,1) = A(i-1,1) + h ;
   K1 = h*f1(A(i-1,3));
   K2 = h*f1(A(i-1,3)+K1/2);
   K3 = h*f1(A(i-1,3)+K2/2);
   K4 = h*f1(A(i-1,3)+K3);
   A(i,3) = A(i-1,3) + (K1 + 2*K2 + 2*K3 + K4)/6;
   A(i,2) = f2(A(i,1));
  
   A(i,4) = A(i,2) - A(i,3);
end

r = A(:,1); % Assinging r the first column of A
s1 = A(:,3); % Assinging s1 the second colun of A
s2 = A(:,2); % Assinging s2 the thrid column of A
s3 = A(:,4); % Assinging s3 the forth colun of A

% results
figure(1)
plot(r,s1,'r',r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Runge-Kutta order 4');
legend('Approcimate solution' , 'Exact solution', 'location','best');

%////////////////////////////////////////////////////////////////////////
%   Runge-Kutta-Felhberg Method 

%Initial variables
Flag = 1;
hmax = 0.2; %
h=hmax;
hmin =0.01;
tol = 0.00002;

N = (b-a)/hmin;
A = zeros(N+1,4);
A(1,1) = t; A(1,2) = w; A(1,3) = w; 
i=1;

while(Flag)
   
   % calculate next step
   K1 = h*f1(A(i,2));
   K2 = h*f1(A(i,2)+K1/4);
   K3 = h*f1(A(i,2)+(3/32)*K1 +(9/32)*K2);
   K4 = h*f1(A(i,2) + (1932/2197)*K1 - (7200/2197)*K2 +(7296/2197)*K3);
   K5 = h*f1(A(i,2) + (439/216)*K1 -8*K2 +(3680/513)*K3 -(845/4104)*K4);
   K6 = h*f1(A(i,2) - (8/27)*K1 +2*K2 -(3544/2565)*K3 + (1859/4104)*K4 -(11/40)*K5);
    
   R = (1/h)*abs( (1/360)*K1 -(128/4275)*K3 -(2197/75240)*K4 + (1/50)*K5 + (2/55)*K6);
   
   %adjustments
   if( R <= tol )
       A(i+1,1) = A(i,1)+h;
       A(i+1,2) = A(i,2) + (25/216)*K1 + (1408/2565)*K3 + (2197/4104)*K4 -(1/5)*K5;
       A(i+1,3) = f2(A(i+1,1));
       A(i+1,4) = abs(A(i+1,2)-A(i+1,3));
       i=i+1;
   end
   
   
   sigma = 0.84*(tol/R)^(1/4);
   
   %determine next step size
   if( sigma <= 0.1)
       h=0.1*h;
       
        elseif ( sigma >= 4)
             h=4*h;
       
        else 
            h = sigma*h;
       
   end
   
   if (h > hmax)
       h = hmax;
   end
   
   if (A(i,1)>=b)
       Flag = 0;
       
        elseif (A(i,1) + h > b)
           h = b-A(i,1);
           
        elseif (h < hmin) % step size reduced below minimum ( diverging from accurate solution)
           Flag = 0;
           fprintf('minimum h exceeded procedure completed unsuccessfully');
   end
    
end

Temp = zeros(i,4);
Temp = A(1:i,:);
A=Temp;

r = A(:,1); % Assinging r the first column of A
s1 = A(:,3); % Assinging s1 the second colun of A
s2 = A(:,2); % Assinging s2 the thrid column of A
s3 = A(:,4); % Assinging s3 the forth colun of A

figure(2)
plot(r,s1,'r',r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Runge-Kutta-Fehlberg Method');
legend('Approcimate solution' , 'Exact solution', 'location','best');
