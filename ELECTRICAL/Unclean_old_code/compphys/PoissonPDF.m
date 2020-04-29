function [ P ] = PoissonPDF( n , v )
% generates a poision pdf for a set of values

P = ((v.^n)./factorial(n)).* exp(-v);

end

