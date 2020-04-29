function [ f ] = bess1( H,fc,B )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

p= [1 0 0]-((1/H)-1)*B*[0 1 0] + (fc^2)*[0 0 1];
F=roots(p);

f=F(1);

end

