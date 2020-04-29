
n = 9;
h = 1/(n+1);
x=zeros(n+2,1);

for i=2:n+2 x(i)=(i-1)*h; end

q=@(t) pi^2;
p=@(t) 1;
fRR = @(t) 2*pi^2*sin(pi*t);

Q=zeros(6,n+1);

for i=1:n-1 q1i =@(t) (x(i+2)-t)*(t-x(i+1))*q(t);
            Q(1,i) = SimpsonRule(x(i+1),x(i+2),100,q1i)/h^2;
end

for i=1:n q2i =@(t) (t-x(i))^2*q(t);
            Q(2,i) = SimpsonRule(x(i),x(i+1),100,q2i)/h^2;
end

for i=1:n q3i =@(t) (x(i+2)-t)^2*q(t);
            Q(3,i) = SimpsonRule(x(i+1),x(i+2),100,q3i)/h^2;
end

for i=1:n+1 
            Q(4,i) = SimpsonRule(x(i),x(i+1),100,p)/h^2;
end

for i=1:n fRR5i =@(t) (t-x(i))*fRR(t);
            Q(5,i) = SimpsonRule(x(i),x(i+1),100,fRR5i)/h;
end

for i=1:n fRR6i =@(t) (x(i+2)-t)*fRR(t);
            Q(6,i) = SimpsonRule(x(i+1),x(i+2),100,fRR6i)/h;
end

A=zeros(n,n);
b=zeros(n,1);
for i=1:n A(i,i) = Q(4,i)+Q(4,i+1)+Q(2,i)+Q(3,i); end
for i=1:n-1 A(i,i+1) = -Q(4,i+1)+Q(1,i); end
for i=2:n A(i,i-1) = -Q(4,i)+Q(1,i-1); end
for i=1:n b(i,1) = Q(5,i) + Q(6,i); end

c = zeros(n+2,1);
c(2:n+1) = A\b;
Table = [x c sin(pi*x)];
d = Table(:,2) - Table(:,3);
Table = [Table d]

plot(Table(:,1),Table(:,2),'r.',Table(:,1),Table(:,3),'b')

xlabel('t-axis','fontsize',14)
legend('Approximation','Exact Solution','location','best')
title('Rayleigh-Ritz Method')
