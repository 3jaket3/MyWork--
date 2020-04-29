x=linspace(-2,7,50);
for k=1:1:length(x)
f(k)=x(k)^3-8*x(k)^2+30
end
plot(x,f)