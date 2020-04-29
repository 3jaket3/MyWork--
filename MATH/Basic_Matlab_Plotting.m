%{
    Basic Matlab Plotting

    9/17/2014   Jake Tully

    This Script plats basic funtions and ansewers some lab questions

%}

%part A
clear
clc
close all

B=@(t) 250./(1+56.75*exp(-0.17.*t));
ansewer1=B(1)
ansewer4=B(4)
x=[1 4];
ansewerx=B(x)
figure(1);
fplot(B,[0 40])
xlabel('time in hours')
ylabel('number of bacteria in thousands')

x1=linspace(0,40,50);
clear B
B=@(t) 250./(1+56.75*exp(-0.17.*t))-150;
ansewerx1=B(x1);
figure(2);
plot(x1,ansewerx1)
xlabel('time in hours')
ylabel('number of bacteria in thousands with shifted axis')
T=fzero(B,25);
fprintf('150000 bacteria will have grown after %f hours\n \n',T  )

%part B
M=@(R) (4*pi/3)*(0.03*R^2-0.0003*R+0.01^3)*8900-100;
figure(3)
 fplot(M,[0 0.4]);
 xlabel('radius of the hollow sphere')
 ylabel('Mass of the hollow sphere')
 m=fzero(M,0.3);
 C=[1118.4 11.184 -99.9627];
 m1=roots(C);
 fprintf('The radius of the sphere with a mass off 100kg:\n is %f using the fzero method\n is %f and %f using the roots method\n',m,m1)
clear
