%{

Frog Vs. Toad, Random Race

5/14/2018 Jake Tully

This simulation races a frog vs a toad 3 meters
the frog and toad have diffrent random probabilites to leap
and diffrent leap distances. The simulation stops when either
the frog or the toad finish the race. 1000 trials are conducted for
varying probabilites that the toad or frog will leap.
and the statistics are recorded.


%}
clear 
clc

% set initial variable
fwins = 0;
twins = 0;
k =0;
for prob=0.1:0.01:0.9  %vairy probability of a leap
 k=k+1;
for i = 0:1000 % number of trials
%initialize variables
xf = 0; % distance frog
xt = 0; % distance toad
t = 0; % time
xT = zeros();
xF  = zeros();
T= zeros();
while(xt < 3 && xf < 3)
   t = t+1;
   T(t) = t;
    if(mod(t,3) == 0 && rand() > prob) % every 3 seconds the toad might leap
        xt = xt + 0.15;
    end
    if(mod(t,2) == 0 && rand() > prob) % every 2 seconds the frog might leap
        xf = xf + 0.1;
    end
     xT(t) = xt;
     xF(t) = xf;
end


% store results of trials
dt(i+1) = xt;
df(i+1) = xf;
tt(i+1) = t;
if(xt > xf)
   twins = twins +1; 
else
    fwins = fwins+1;
end

end
% store results for probability value
Prob(k) = prob;
time(k) = mean(tt);
end

% plot some statistic of intereast
figure(1)
plot(Prob,time)
xlabel('Probability of a leap')
ylabel('Time for the race to finish')
title('Frog Vs. Toad')



