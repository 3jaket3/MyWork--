function [ V ] = Newton( a,b,alpha,beta,U )
%NEWTON Summary of this function goes here
%   Detailed explanation goes here

N = length(U);
h = (b-a)/(N+1);
V = zeros(N,1);

f=@(x,y1,y2)  y2*cos(x)-y1*log(y1);
V(1,1) = 2*U(1,1)-U(1,2)+h^2*f(a+h,U(1,1),(U(1,2)-alpha)/(2*h))-alpha;
V(N,1) =2*U(1,N)-U(1,N-1)+h^2*f(a+N*h,U(1,N),(beta-U(1,N-1))/(2*h))-beta;
for i=2:(N-1)
    V(i,1)=-U(1,i-1)+2*U(1,i)-U(1,i+1)+h^2*f(a+h*i,U(1,i),(U(1,i+1)-U(1,i-1))/(2*h));
end

end

