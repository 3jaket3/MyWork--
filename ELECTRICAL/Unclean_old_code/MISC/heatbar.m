n=linspace(0,100,100);
x=linspace(0,10,10);
y=linspace(0,10,10);
H=linspace(0,100);
for j=1:length(y)
for k=1:length(x)
for i=1:length(x)
H(i) = (1/n(i)*sinh(n(i)*pi*0.3))*(sinh(n(i)*x(k)*pi*0.3)*sin(y(j)*n(i)*pi*0.3))
end
H1(k,j)=sum(H)
end
end