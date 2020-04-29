%{

%Umbrella problem
%jake tully 2/10/2017


This program simulates a random chance of rain and 
keeps track of a umbrella's location in order
to determine the likelihood of being rained on.

%}

% Set initial variables
isRaining = 0;
days = 5000;
umbrellaAtHome = 1;
umbrellaAtWork = 0;
rainedOn = 0;
rain = zeros(1,days);
day = zeros(1,days);
rainAtWork = linspace(1,days);
rainAtHome = linspace(1,days);


for i= 1:days % iterate through each day

    day(i) = i;    
    
    %set probabilites for rain on each day.
    rainAtWork(i) = cos(i/180)^2;
    rainAtHome(i) = sin(i/400)^2;
    
    % at home leaving for work
    if ( rainAtHome < rand()) % if raining at home
        
        if ( umbrellaAtHome ) % check umbrella location
            % use umbrella if available
            umbrellaAtHome = 0;
            umbrellaAtWork = 1;
        else
            % get rained on
            rainedOn = rainedOn + 1;
        end
        
    end
    
    %at work leaving for home
    if ( rainAtWork < rand() ) % if raining at work
         
        if ( umbrellaAtWork) % check umbrella loacation
            % use umbrella if available
            umbrellaAtWork = 0;
            umbrellaAtHome = 1;
        else
            % get rained on 
            n = rainedOn + 1;
        end
        
    end
    
    
    rain(i) =  rainedOn/i; % percentage of days that you get rained on at current time
    
end

figure(1)
plot(day,rain)
xlabel(' Current Day ')
ylabel(' Current Percentage of Days Rained on')
title(' How often will i get Rained on ')