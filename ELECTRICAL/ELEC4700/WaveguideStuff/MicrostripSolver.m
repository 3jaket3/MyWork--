% H&T Inc.
% Microstrip Solver



clear 
clc
close all

%%silicon dioxide parameters
er= 3.705;
sigmaI = (1/(2.3*10^3));
10^-12;
mI= 0;
%% Copper parameters
mc = 1.256629*10^-6;
sigmaC = 5.96*10^7; % S/m

%% line Parameters
V = 3.1;
mo = 4*pi*10^-7;
eo = 8.854*10^-12;
Zg = 20; %ohms
Zl = 25 + i*10; %ohms
f= 2.4*10^9;  %GHz
c= 299792458; %m/s
l= 7;   %cm

%% 


Zo = @(s) ZoMicroStrip( s, er) -Zg;

figure(2)
fplot(Zo,[0 20])
s = fzero(Zo,7)
Zo = ZoMicroStrip( s, er);
x = 0.56*((er-0.9)/(er+3))^-0.05;
y = 1 + 0.02*log(s^4 + ((3.7*10^-4)*s^2)/(s^4 +0.43)) + 0.05*log(1 + (1.7*10^-4)*s^3);
eff = (er + 1)/2 +((er-1)/2)*(1+10/s)^-x*y;

up = c/sqrt(eff);

lambda = (up/f)*10^-3;% to get to cm
B = (2*pi*f)*sqrt(eff);

Rs = sqrt((pi*f*mc)/sigmaC);

C = sqrt(eff)/(Zo*c);
L = (Zo^2)*C;
G = sigmaI*s;

alpha = @(w) real(sqrt(((2*Rs)/w + i*2*pi*f*L)*(G +i*2*pi*f*C)));
wo=0;
while alpha(wo) > 0.05
    wo = wo + 0.001;
end
    h= wo/s;
  A= alpha(wo);
wo
figure(3)
fplot(alpha,[0 wo+0.01])
    





Pav = (V^2)/(2*Zo);



z= linspace (0,0.07,200);

for t= 0:10^-10:10^-8
    
   wave =exp(-z.*A).*V.*cos(2*pi*f*t -B.*z);
   pause(0.1)
    plot(z,wave)
end

IntegerWavelengths = 0.07/lambda