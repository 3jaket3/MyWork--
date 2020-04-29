%{
    Active Band Pass Filter Plot

    6/23/2015   Jake Tully

    This script plots a filter with band pass action
    chebyshev response 3 db of ripple and 4th order roll off
    bandpass gain target of 0dB to -3dB

%}

% Set the numerator and denominator of the TF.
%In this case numerator is a constant.
Num= [2.48e6 0 0] ;
% Denominator = S^4 + 16419s^3 + 134787490s^2 + 648191274000s +
% 1558473004000000
Dem = [1 1.43e3 3.08e7 1.96e10 1.869e14];
% Set the frequency range to plot and the value of s.
f = 100:1:2e3;
s = 2*pi*f*j;
% Determine the magnitude of the frequency response in dB.
FR = 20*log10(abs(polyval(Num,s) ./ polyval(Dem,s)));
% Plot the result.
semilogx(f,FR)
xlabel ('Frequency (Hz)')
ylabel ('Amplitude (dB)')
axis ([0 2e3 -35 30])
polyCoeff = [1 1.43e3 3.08e7 1.96e10 1.869e14];
polyRoots = roots(polyCoeff);
% polyRoots is a vector with the 4 roots of the polynomial. Combine the first
% two and the second two to create two second order polynomials
poly1Coeff=poly(polyRoots(1:2))
poly2Coeff=poly(polyRoots(3:4))
% poly1Coeff=[1 4809 3.9479e7], poly1Coeff=[1 11610 3.9479e7]