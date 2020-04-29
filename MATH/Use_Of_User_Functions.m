%{
    Use of Functions in Matlab

    9/26/2014   Jake Tully

    This Script demonstrates the use of user defined functions in matlab
    the function that goes with this script is called { overlap }

%}

clc
clear
close all

R1=100;
R2=50;
D=linspace(50,160,160);
A=ones(size(D));
A1=ones(size(D));
f=@(D)overlap(R1,R2,D);

fplot(f,[50 160])

for k=1:1:length(D)
    A(k)=overlap(R1,R2,D(k));
end


for k=1:1:length(D)
    A1(k)=overlap(R1,R2,D(k))-2000;
end

figure(2)
plot(D,A1)

p=@(D) f(D)-2000;

figure(3)
fplot(p,[50 160])

D2=linspace(50,160,11);
A2=ones(size(D));
fprintf( 'the distance is %f for a area of 2000mm^2\n\n', fzero(p,[50 160]))

for l=1:1:length(D2)
    A2(l)=overlap(R1,R2,D2(l));
    fprintf('%f\n',A(l))
end
