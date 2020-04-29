function [ P ] = pdfLogNormal( x,m,s )
% calculations the probability for a log normal distribution 
%  x = the probability of specific point
%  m = the average value of the distribution
%  s = the standard deviation of the distribution


P = (1./sqrt(2.*pi.*s.^2)) .*(1./x) .* exp( -(log(x) -m).^2 ./(2*s.^2 )) ;


end

