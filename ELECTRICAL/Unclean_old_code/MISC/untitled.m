function Hd = untitled
%UNTITLED Returns a discrete-time filter System object.

% MATLAB Code
% Generated by MATLAB(R) 8.1 and the Signal Processing Toolbox 6.19.
% Generated on: 18-Nov-2015 23:08:15

N      = 4;     % Order
Fpass1 = 398;   % First Passband Frequency
Fpass2 = 720;   % Second Passband Frequency
Apass  = 3;     % Passband Ripple (dB)
Fs     = 2200;  % Sampling Frequency

h = fdesign.bandpass('n,fp1,fp2,ap', N, Fpass1, Fpass2, Apass, Fs);

Hd = design(h, 'cheby1', ...
    'SystemObject', true);



