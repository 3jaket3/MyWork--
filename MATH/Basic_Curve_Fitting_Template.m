%{
    Curve Fitting
    
    11/20/2014 Jake Tully

    This script is a template for using polyfit and
    least squares approximation to fit curves to data
%}



function [  ] = Curve_Fitting_Example(  )
clear
clc
close all

Polyfit_Template()
Exponential_Fit()
end

function [  ] = Polyfit_Template(  )
% Data
D = [0 4 8 12 16 20];
A = [67.38 74.67 82.74 91.69 101.60 112.58];

% p = polynomial coefficients
% polyfit( x,y,n) where x & y = data | n = degree of polynomial
p = polyfit(D,A,1);
y = polyval(p,D);

p = polyfit(D,A,2);
y1 = polyval(p,D);

figure(1)
plot(D,A, 'rs', D,y,D,y1,'g')
xlabel( ' Number of Days ')
ylabel( ' Number of Bacteria ')
title( ' Extrapolation of Bacteria Data ')
legend( {'Experimental Data','Degree 1 polynomial fit', 'Degree 2 polynomial fit'},'Location','northwest');

f=@(x) x^2*p(1) + x*p(2) + p(3);

fprintf('The number of bacteria at 30 days is %f\n\n', f(30))

end

function [  ] = Exponetial_Fit(  )


% Exponetial fit least squares approximation
% P(t) = a*exp(bt)
% lnP(t) = ln(a) + bt
% solve for a and b ... Ax = b
T = [0 10 20 30 40]+273;
Kw = [0.1164 0.2950 0.6846 1.467 2.929]*10^-14;

Kw = -log10(Kw);
p = ones(size(T));
A = [1./T ; log10(T) ; T ; p];
A = transpose(A);

abcd=A\transpose(Kw);

for k = 1:length(p)

    p(k) = abcd(1)*(1/T(k)) + abcd(2)*log10(T(k)) + T(k)*abcd(3) + abcd(4);
    
end

figure(2)
plot( T,Kw, 'rs', T,p)
xlabel( 'Temperature in Kelvin')
ylabel( 'Equilibrium constant Kw ')
title( ' Temperature dependance of Kw ')
legend( 'Experimental Data ','Fitted curve')

end