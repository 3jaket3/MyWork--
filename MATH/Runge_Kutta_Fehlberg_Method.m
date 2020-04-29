%{
    Runge-Kutta-Felhberg Method

    10/9/1017 Jake Tully

    This Script is an example of the Runge-Kutta-Felhberg Method
    & Runge-Kutta 4th Order

%}


clear 
clc
close all
format long

f1 = @(t,y) 1 + y - t^2; % initial value
f2 = @(t) (t+1)^2 - 0.5*exp(t);
a = 0; % initial mesh point
b = 2; % final mesh point
alpha = 0.5; % initial value of the solution

t = a;
w = alpha;

TOL = 10^-5;
Flag = 1;
hmax = 0.25;
hmin = 0.01;
h = hmax;
i = 2;

A2 = zeros (100,6);
A2(1,1) = t; A2(1,2) = w; A2(1,3)=w; A2(1,4) = h;

% row 1 ti | row2 y(ti) | row 3 wi | row 4 hi | row 5 Ri|
%row 6 |yi -wi| 
while Flag == 1
    
  F1 = h * f1(A2(i-1,1),A2(i-1,3));
  F2 = h * f1(A2(i-1,1)+h/4,A2(i-1,3)+ (1/4)*F1);
  F3 = h * f1(A2(i-1,1)+(3/8)*h,A2(i-1,3) +(3/32)*F1 + (9/32)*F2);
  F4 = h * f1(A2(i-1,1)+(12/13)*h,A2(i-1,3) +(1932/2197)*F1 - (7200/2197)*F2 + (7296/2197)*F3);
  F5 = h * f1(A2(i-1,1)+h,A2(i-1,3) + (439/216)*F1 - 8*F2 + (3680/513)*F3 - (845/4104)*F4);
  F6 = h * f1(A2(i-1,1)+h/2,A2(i-1,3) - (8/27)*F1 + 2*F2 -(3544/2565)*F3 + (1859/4104)*F4- (11/40)*F5);
  R = (1/h)*abs(( (1/360)*F1 - (128/4275)*F3 - (2197/75240)*F4 + (1/50)*F5 + (2/55)*F6));
 
  if ( R <= TOL )
      
       A2(i,1) = A2(i-1,1) + h ;
       A2(i,2) = f2(A2(i,1));
       A2(i,3) = A2(i-1,3) + (25/216)*F1 + (1408/2565)*F3 + (2197/4104)*F4 -(1/5)*F5;
       A2(i,4) = h;
       A2(i,5) = R;
       A2(i,6) = A2(i,2) - A2(i,3);
       
       i = i + 1 ;   
  end

  sigma = 0.84*(TOL/R)^(1/4);
  
  if ( sigma <= 0.1)
     h = 0.1*h;
        elseif ( sigma >= 4)
            h = 4*h;
        else
            h = sigma*h;
  end
  
  if (h > hmax)
      h = hmax; 
  end
  
  if(A2(i-1,1) >= b)
     Flag = 0;
    
      elseif ( A2(i-1,1) + h > b )
          h = b - A2(i-1,1);
     
      elseif ( h < hmin )
          Flag = 0;
          fprintf('minimum h exceeded procedure completed unsuccesfully');
  end
            
end

Temp = zeros(i,6);
Temp = A2(1:i-1,:);
A2 = Temp;

r = A2(:,1); % Assinging r the first column of A
s1 = A2(:,3); % Assinging s1 the second colun of A
s2 = A2(:,2); % Assinging s2 the thrid column of  A

figure(1)
plot(r,s1,'r', r,s2,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title( ' Runge Kutta Fehlberg Method ')
legend('Approcimate solution' , 'Exact solution', 'location','best');

