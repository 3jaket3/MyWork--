function [ J ] = Jacobian( a,b,alpha,beta,U )
%JACOBIAN makes the jacobian

N = length(U);
h = (b-a) / (N+1);

f_y1 = @(x,y1,y2) log(y1) +1 ;
f_y2 = @(x,y1,y2) cos(x);

U1 = [alpha U beta];

J = zeros(N,N);
for j=2:N
    i=j-1;
    J(i,j) = -1 +(h/2)*f_y2(a+h*i,U1(1,i+1),(U1(1,i+2)-U1(1,i))/(2*h));
end

for j=1:N
    i=j;
    J(i,j) = 2+h^2*f_y1(a+h*i,U1(1,i+1),(U1(1,i+2)-U1(1,i))/(2*h));
end

for j=1:N-1
    i=j+1;
    J(i,j) = -1 -(h/2)*f_y2(a+h*i,U1(1,i+1),(U1(1,i+2)-U1(1,i))/(2*h));
end


