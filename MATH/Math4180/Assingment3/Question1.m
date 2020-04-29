clear 
clc

a = 0; b = pi/2; alpha =1; beta=exp(1); N=10; TOL=10^(-8); M=1000;
h=(b-a)/(N+1);
U = zeros(1,N);

for i=1:N
    U(1,i) = alpha + i*h*(beta-alpha)/(b-a);
end
k=1;

while (k<=M)

    Z = Jacobian(a,b,alpha,beta,U);
    F = Newton(a,b,alpha,beta,U);
    
    U0 = U-transpose(((Z^(-1))*F));
    
    if norm(U-U0) < TOL
        Y=[alpha U0 beta];
        break;
    end
    k=k+1;
    U=U0;
end

if k>M
    fprintf('Maximum iteration is exceeded \n')
end

B = zeros(N+2,4);
x=zeros(N+2,1); for i=1:N+2 x(i,1)= a+(i-1)*h; end
B(:,1)=x;
B(:,2)=Y;
B(:,3)= exp(sin(x));
B(:,4) = abs(B(:,3)-B(:,2));
B
r = B(:,1);
s1 = B(:,2);
s2 = B(:,3);
plot(r,s1,'r.',r,s2,'b')
xlabel('x-axis','fontsize',14)
ylabel('y-axis','fontsize',14)
legend('Approcimate solution','Exact solution','location','Best')
title('Nonlinear Finite Difference Method')

