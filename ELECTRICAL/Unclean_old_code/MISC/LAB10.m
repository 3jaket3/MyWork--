function [  ] = LAB10( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clear
clc

load SCO2.txt 
load cpvsT.txt

  
K = SCO2(:,1);
cp =SCO2(:,6);

h=K(2)-K(1);

fprintf('The entropy change is %f using trapz \n and %f with simpsons\n\n',trapz(K,cp),Simpsons (h,cp) )

K10 = K(5:length(cp));
cp10 = cp(5:length(cp));
    
h=K(2)-K(1);
fprintf('The entropy change is %f using trapz \n and %f with simpsons\n\n',trapz(K10,cp10),Simpsons (h,cp10) )

for k=1:10
   
    K2 = K(1:10);
    cp2 =cp(1:10);
    
end

xin= 300:0.1:345;
figure(1)

pp=interp1(K2,cp2,xin, 'cubic');
p=polyfit(K2,cp2,9);
p1=polyval(p,xin);
plot(K2,cp2,'rs',xin,pp,'k',xin,p1)


f=@(H) part3(H) - 700;
figure(2)
fplot(f,[1 30])
fzero(f,10)
end

function [ x ] = part3(H)

f = @(z,H) 200*(z./(5+z)).*exp(-2.*z./H);
x = quad(f,0,H,[],[],H);
end

function [ x ] = Simpsons (h,cp )

n = length(cp);
x=(h/3)*(cp(1)+cp(n));
   
x = x + 4*sum(cp(2:2:(n-1)))*(h/3);
    
x = x + 2*sum(cp(3:2:(n-2)))*(h/3);

end