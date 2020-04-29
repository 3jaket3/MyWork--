function [  ] = Curve_Fitting_II(  )
% jaketully 100904392
%   caclulates all parts of lab 8
clear 
clc
close all

Weight_Vs_Surface_Area()
X_Vs_Y()
Time_Vs_Population()
end

function [  ] = Weight_Vs_Surface_Area(  )
% fits a line to the data provided
%   with the fit line predicts a unknow value of surface area
W = [ 70 75 77 80 82 84 87 90];
A = [ 2.10 2.12 2.15 2.20 2.22 2.23 2.26 2.30];
p = polyfit(W,A,1);
Y= polyval(p,W);

figure(1)
plot(W,A, 'md',W,Y)
title(' Weight vs Surface Area (of a person)')
xlabel(' Weight (Kg)')
ylabel('Surface Area (m^2)')
grid on
R=corrcoef(A,Y);

fprintf('Part 1 \n\nThe corellation coefficeint is %f\n\nThe surface area of a person who weighs 78.5kg is about %f\n\n',R(2), polyval(p,78.5))
end

function [  ] = X_Vs_Y(  )
% fits a line to the data provided
%   finds the maximum of the fuction after its fitted
x = [ 3 4 5 7 8 9 10 11];
y = [ 1.6 3.6 4.4 3.4 2.2 2.8 3.8 4.6 ];
p = polyfit(x,y,3);
x1 =  x ;
Y = polyval(p,x1);
R = corrcoef(y,Y);
x1 = [2 x 12];
Y = polyval(p,x1);

figure(2)
plot(x,y, 'kv',x1,Y)
title(' x vs y')
xlabel('x')
ylabel('y')
grid on
p1 = polyder(p);

f1=@(x) x.^2.*p1(1) + x.*p1(2) + p1(3);
f=@(x) -1*(x.^3*p(1) + x.^2.*p(2) + x.*p(3) + p(4));
fprintf('Part2\n\nThe correlation coefficeint is %f \n\nThe maximum occurs at %f using fzero \nand %f using fminbnd\n\n',R(2),fzero(f1,[0 8]), fminbnd(f,3,8))

end

function [  ] = Time_Vs_Population(  )
% finds the coeffiecients of a suppllide formula that fits the data 
% reurns A,B,C

t = [ 0.5 1 2 3 5 6 7 8 9 ];
t1 = log([ 0.5 1 2 3 5 6 7 8 9 ]);
pop1 =[ 6.0 4.4 3.2 2.7 2.2 1.9 1.7 1.4 1.1 ];
pop = log([ 6.0 4.4 3.2 2.7 2.2 1.9 1.7 1.4 1.1 ]);

p = polyfit(t1,pop,1);
P = polyval(p,t1);
A = p(1);
B = p(2);
fit = @(x)  B*exp(A*x) ;

figure (3)
hold on
fplot(fit,[0.5 9])
plot(t,pop1, 'rs')
hold off

figure(4)
plot(t1,pop, 'rs',t1,P)
title(' time vs Natural log of population)')
xlabel('time')
ylabel('population')
grid on
R = corrcoef(pop,P);
fprintf('Part3\n\n The correlation coefficient is %f',R(2))

end