function [ Int ] = simpson1D( x, ax, bx )
% Simpsions Integration in 1 demension
num = length(x);
h = (max(x)-min(x))/(6*num);
n = 1:1:length(x)-2;

Int = x(n) + 4*x(n+1) + x(n+2);

Int = sum(h*Int);




end


