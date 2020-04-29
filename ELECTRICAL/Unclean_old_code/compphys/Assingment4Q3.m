%{
    

%}

clear 
clc
close all

% In a very large data set nb = 3.2 can be treated as poisson variable
% a)

nb = 3.2;
ns = 5.2;
n = linspace(0,16,17);
y = ((nb.^n)./factorial(n)).* exp(-nb);
x = ((ns.^n)./factorial(n)).* exp(-ns);
plot(n,y,'--o', n,x,'g--o')

% the value n =0 is element 1 in x and y thus shifted by 1
alpha = sum(y(8:17));
beta = sum(x(1:8));

fprintf('from the graph we can see that P(X>=7) = %f is the tcut\n\n',alpha)

plot(n,y,'--o', n,x,'g--o',[8 8],[0 0.25],'k')
title('Poisson Distrobutions (Blue Ho) (Green H1)')
xlabel('Background counts')
ylabel('Probability')

fprintf('The value of beta is %f\n\n',beta)

fprintf('The the power with respect to H1 is %f\n\n',1-beta)

% Ph1 = (number of background events h1 with t < tcut)/
%( total number of background events t<tcut)  

Ph1 = sum(x(1:8))/(sum(x(1:8)) + sum(y(1:8)));

fprintf('The single purity of the alternative hypothesis is %f\n\n',Ph1)

fprintf('The p-value of 11 observed events all due to background is %f\n\n',y(12))

fprintf('The Z score is %f\n\n', (11-nb)/sqrt(nb))
