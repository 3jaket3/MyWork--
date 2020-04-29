function [  ] = quiz2(  )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

B=400;
fc=1000;
H= [0.01:0.005:0.16];
f= ones(size(H));
fprintf('responce         frequency\n')
for k=1:1:length(H)
    
    f(k)=bess1(H(k),fc,B);
    fprintf('%f         %f\n',H(k),bess1(H(k),fc,B))
end

plot(H,f)
ylabel('response')
xlabel('frequency')
title('frequency vs responce')
grid on

end

function [ f ] = bess1( H,fc,B )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

p= [1 0 0]-((1/H)-1)*B*[0 1 0] + (fc^2)*[0 0 1];
F=roots(p);
if(F(1)<1000&&F(1)>1)
    f=F(1);
    return
end
if(F(2)<1000&&F(2)>1)
    f=F(2);
    return
end
f=0;
end
