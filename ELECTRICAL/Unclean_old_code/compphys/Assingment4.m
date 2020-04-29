% Assingment 4 

clear
clc
close all
format long
% Question 1
t=0;
t1=0;
pickup = 0;
gotpick = 0 ;
Ncars = 0;
x=0; % counter for cars
y=0; % counter rides
cars=0;
cx=0;
for k=1:10
for i=1:2160000
   
   t= t+1; % time in seconds
   t1=t1+1;
   min = t/60;
   pmin= t1/60;
   hour = min/60;
   phour = pmin/60;
   
   H(i) =(i/60)/60;
   car = rand*min > 0.84656;
   cx = cx+ car;
   C(i) =  cx;
   if (car)
       x=x+1;
    
      pickup = car*rand < 0.0985 ;  
      gotpick = gotpick + pickup;
      Time(x) = min; 
      Ncars = Ncars +car;
      cars = cars+car;
      
      if (pickup)
          y=y+1;
          pTime(y) = phour;
         t1=0; 
         pcars(y) = cars;
         cars = 0;
      end
      car=0;
      pickup = 0;
      t=0;
      
   end    
    

   
   riderate(i) = gotpick;
    
end
  pRide(k) = gotpick/Ncars;
end

   stotal= i;
   mtotal = stotal/60;
   htotal = mtotal/60;
 
   

   hold on
   plot(H,riderate)
   title(' # of rides Vs time [H]')
   xlabel('# of hours')
   ylabel('# of rides got')

   
   figure(2)
   hist(Time,50)
   title('Histogram of a time between cars')
   xlabel('Time Interval[M]')
   ylabel('Bin Count')
   
   figure(3)
   hist(pTime,50)
   title('Histogram of a time between rides')
   xlabel('Time Interval[H]')
   ylabel('Bin Count')
   
   figure(4)
   hist(pcars,50)
   title('Histogram of a passing cars between rides')
   xlabel('number of cars passed')
   ylabel('Bin Count')

  fprintf('\n For the distribution in figure(2) the average time interval between cars is %f [M]\n the Variance is %f the standard deviation is %f \n', mean(Time),var(Time),std(Time))
  fprintf('\n theese are estimators \n the distribution can be decided \n and a analytical value can be calculated\n assuming log normal\n')
  fprintf('\n For the distribution in figure(3) the average time interval between rides is %f [H]\n the Variance is %f the standard deviation is %f \n', mean(pTime),var(pTime),std(pTime))
  fprintf('\n theese are estimators \n the distribution can be decided \n and a analytical value can be calculated\n assuming log normal\n')
  fprintf('\n For the distribution in figure(4) the average interval between rides is %f [Cars]\n the Variance is %f the standard deviation is %f \n', mean(pcars),var(pcars),std(pcars))
  fprintf('\n theese are estimators \n the distribution can be decided \n and a analytical value can be calculated\n assuming log normal\n')
  
  fprintf('\n After 10 simulations the recovered probablity\n of getting a ride is %f\n\n',mean(pRide))

  % a) probability that a student will still be waiting after 60 cars
  % 1-P will give the probability of having already got a ride
  %
  fprintf(' for this distrobution the probability of still waiting after 60 cars is %f\n', cdfLognormal(60,mean(pcars),std(pcars)))
  
  % b) probability that a student will still be waiting for a ride after 60
  % minutes or 1 hour
  
   fprintf(' for this distrobution the probability of still waiting after 1 Hour is %f\n', cdfLognormal(1,mean(pTime),std(pTime)))
  
  
  
  
 
  
  
  
  
  
  