%{
 MarkovChain solution

4/7/2020 Jake Tully

This program solves a simple markov chain

%}


clear
 clc
 
A = [-1 0.5 0 0 0 0;
    0.2 -1 1 0 0 0;
    0.4 0 -1 0.2 0 0.5;
    0.4 0.5 0 -1 0 0;
    0 0 0 0.4 -1 0; 
    0 0 0 0.4 0 -1];
B = [-2; -0.8; -3.2; 0; 0; 0 ];

arrivalRates = linsolve(A,B)

D = [ 0.1; 0.1; 0.02 ;0.1; 0.1; 0.1];
serviceRates = 1./D
 Utilization = arrivalRates./serviceRates