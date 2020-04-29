function [ P ] = cdfLognormal(x,m,s )
%   Cumulative distribution function for Log Normal Distrobution
%   X = probability of a value
%   m = mean of distrobution
%   s = standard deviation

P = (1/2) .* ( 1 + erf(log(x)-m) ./ (s.*sqrt(2)));


end

