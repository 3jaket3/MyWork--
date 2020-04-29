%Jake Tully 100904392
%
% TE Modes optical waveguide
% Nano particals on core


%Parameters
c = 299792458; % m/s
lambda = 1550*10^-9;
f = c/lambda;
up = lambda*f;
n1 = 1.45;
n2 = 1.44;
nm = 0.5 - 11i;
DelNeff = 10^-5;
Bo = (2*pi*1.447)/lambda;
epsilon1 = (8.8541878176*10^-12)*n1^2;
a =4.1*10^-6;
k = sqrt((up^2)/((n1^2-n2^2)*a^2));

kapa = sqrt(k^2*n1^2 - Bo^2);
sigma = sqrt(Bo^2 - k^2*n2^2);

u = kapa*a
w = sigma*a