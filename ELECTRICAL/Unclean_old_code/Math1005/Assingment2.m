% Assingment 2 
%Jake Tully 2/9/2017

% Question 1

f1 = @(x) x^2 * sqrt(x^3 +1);
m = ((f1(2.0000001)-f1(2))/(2.0000001 - 2));
b = f1(2) - m*2;
f2 = @(y) m*y + b;
figure(1)
hold on
fplot(f1,[-3 6])
fplot(f2,[-3 6])
plot(1,-10,'*')
plot(5,72,'*')
plot(-2,68,'*')
plot(-1,24,'*')
hold off

N = @(t) 2*t*sqrt(4*t + 9) +12;
N1 = @(t) 2*sqrt(4*t+9) + (8*t)/sqrt(4*t+9);
N(1)
N(4)
figure(2)
hold on
fplot(N,[0 6])
fplot(N1,[0 6])
hold off

P = @(t) 4*sin(0.5*t)^2 +1;
P1 = @(t) 4*sin(0.5*t)*cos(0.5*t);
figure(3)
hold on
fplot(P,[0,6])
fplot(P1,[0 6])
hold off

f1 = @(x) x^2 * log(x);
fplot(f1,[0.000001 10])