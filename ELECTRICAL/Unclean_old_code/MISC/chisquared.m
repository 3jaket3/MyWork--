function [ X ] = chisquared(m,B,E )
%Uses chi squared to determine the value of planks conerrornt for a given
%data set
%   take the value

for k=1:length(B)
O(k)=((m^B(k)*exp(-m))/factorial(B(k)))*600
x(k)=((E(k)-O(k))^2/O(k))

end
X=sum(x);