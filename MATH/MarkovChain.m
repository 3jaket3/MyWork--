%{
 MarkovChain solution

4/7/2020 Jake Tully

This program solves a simple markov chain

%}

clear
clc
 
A = [-1 0.4 0 0 0 ; -.8 -1 0 -0.2 0 ; -0.2 -1 1 0 0 ; 0 0 -1 1 0 ; 0 -0.4 0 -0.8 1 ];
B = [0.8; 0; 1.2; 3; 0];

arrivalRates = linsolve(A,B)

D = [ 0.5; 1.2; 0.2 ;0.3; 0.6];
serviceRates = 1./D
Utilization = arrivalRates./serviceRates
 
