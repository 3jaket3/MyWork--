function [ XI ] = SimpsonRule( a,b,n,func )
%SIMPSONRULE Summary of this function goes here
%   Detailed explanation goes here
h=(b-a)/n;
XI0 = func(a) + func(b);
XI1 = 0;
XI2 = 0;

for i = 1:(n-1)
    x=a+i*h;
    if mod(i,2) == 0
        XI2 = XI2+func(x);
    else
        XI1=XI1+func(x);
    end
end
XI=h*(XI0+4*XI1+2*XI2)/3;

end

