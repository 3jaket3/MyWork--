% Lab 4 pre lab

% ( non inverting low pass)
clear
clc 
close all

R1 = 1*10^3;
R2 = 318*10^3;

C1 = 0.097*10^-6;

s = linspace(0, 20, 2*10^4);

a1 = (C1*s + (1/R2) +(1/R1))./ ( C1*s +(1/R2));
A1 = 20*log10(a1);
' Gain in Db'
figure(1)
subplot(2,1,1)
semilogx(s, A1)
ylabel(' Gain in Db')
xlabel(' Log scale Frequency')

subplot(2,1,2)
plot(s,a1)
ylabel(' Gain in [V/V]')
xlabel(' Frequency')

fprintf( 'The maximum gain in Db is %f \n\n', A1(1))
fprintf( 'The three Db drop is %f and occurs at %f\n\n',A1(12502),s(12502))

R1 = 9.8*10^3;
R2 =  318*10^3;


C1 = 33*10^-6;
C2 = 0.1*10^-6;

a2 = -(C1*R2.*s)./(( 1 + C1.*s*R1).*( 1 + C2.*s*R2));

A2 = 20*log10(a2);

figure(2)
subplot(2,1,1)
semilogx(s, A2)
ylabel(' Gain in Db')
xlabel(' Log scale Frequency')

subplot(2,1,2)
plot(s,a2)
ylabel(' Gain in [V/V]')
xlabel(' Frequency')

fprintf(' The gain at 5 Hz is %f\n The gain at 3 Hz is %f\n The gain at 0.5 Hz is %f\n\n',A2(12502),A2(7501),A2(1251)) 

a3 = a1 .* a2;
A3 = 20*log10(a3);
figure(3)
subplot(2,1,1)
semilogx(s, A3)
title('Gain(A1*A2)')
ylabel(' Gain in Db')
xlabel(' Log scale Frequency')
subplot(2,1,2)
plot(s,a3)
ylabel(' Gain in [V/V]')
xlabel(' Frequency')


