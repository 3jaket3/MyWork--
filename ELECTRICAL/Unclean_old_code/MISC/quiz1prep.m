%lab 1 test practice material
clear
clc
%jaketully student #100904392      

A=5;
B=3;

tmax=45;

t=linspace(0, tmax, 90);


d=ones(size(t));

for k=1:1:length(t) 
  d(k)=doordistance(A,B,t(k));
end
plot(t,d)

figure (2)

f=@(t) doordistance(A,B,t)-5;
fplot(f,[0 tmax])
a=fzero(f,[0 tmax]);
fprintf('the doors will be 5 meters apart when %f seconds after\n they begin opening.\n\n', a)