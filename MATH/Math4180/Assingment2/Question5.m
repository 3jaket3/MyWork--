clear 
clc
f1 = @(x,u1,u2) u2; % initial value
f2 = @(x,u1,u2) 2*u1^3 - 6*u1 -2*x^3;
p1 = @(u1) 6*u1^2-6; % initial value
f3 = @(x) x+ 1./x;

a = 1; % initial mesh point
b = 2; % final mesh point
alpha = 2; % initial value of the solution
beta = 5/2;
N = 10;% number of intervals between the mesh points
h = (b-a)/N; % step size
x = a;
w1 = alpha;
tk = 0.5;

M = 10;
k=1;
tol = 10^-4;
K1 = [0 0];
K2 = [0 0];
K3 = [0 0];
K4 = [0 0];
while(k<M)

A = zeros (N+1,5); 
A(1,1) = x; A(1,2) = alpha; A(1,3)=tk; 

U1 = 0; U2=1; A(1,4) = f3(a);

for i = 2 :(N+1)
  A(i,1) = A(i-1,1) + h ; % Assomgomg va;ies fpr tje first column of A1  
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


  K1(1) = h*U2;
  K1(2) = h * U1*p1(A(i-1,2));
  K2(1) = h * (U2+K1(2)/2);
  K2(2) = h * (U1+K1(1)/2)*p1(A(i-1,2)) ;
  K3(1) = h * (U2+K2(2)/2);
  K3(2) = h * (U1+K2(1)/2)*p1(A(i-1,2)) ;
  K4(1) = h * (U2+K3(2));  
  K4(2) = h * (U1+K3(1))*p1(A(i-1,2)); 
  U1 = U1 + (1/6)*(K1(1)+2*K2(1)+2*K3(1)+K4(1));
  U2 = U2 + (1/6)*(K1(2)+2*K2(2)+2*K3(2)+K4(2));
  
 
end


if (abs(A(N+1,2)-beta) <= tol)
   break; 
end

tk = tk - (A(N+1,2)-beta)/U1;
k=k+1;
end
 A(:,4) = f3(transpose(A(:,1)));
A(:,5) = abs(A(:,2)-A(:,4));
x=A(:,1);
y=A(:,2);
exacty=A(:,4);
figure(1)
plot(x,y,'r.', x,exacty,'b')
xlabel('t-axis', 'fontsize', 14);
ylabel('y-axis','fontsize',14);
title('Solution of x');
legend('Approcimate solution' , 'Exact solution', 'location','best');