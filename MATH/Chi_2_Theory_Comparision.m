%{

02/12/2015
Jake Tully

This script applies Chi^2 Statistical techniques on data sets

    

%}


clear 
clc
close all

% create data arrays and set initial variables
h_data = [8 12 14 10 19 13 18 15 7 8 17 11 12 7 11 4 3 7 7 0];

Theory1 = [13.1 15.1 16.9 18.3 19.4 19.9 19.9 19.4 18.3 16.9 15.1 13.1 11.1 9.2 7.3 5.7 4.3 3.2 2.3 1.6];

Theory2 = [10.9 12.5 14 15.2 16.1 16.5 16.5 16.1 15.2 14 12.7 11.4 10 8.7 7.4 6.4 5.5 4.9 4.4 4.2];

bins = 1:1:20;
chi1= 0;
chi2 = 0;

% calculate chi^2 values
for i=1:length(h_data)
   
    chi1 = chi1 + (h_data(i)-Theory1(i))^2/Theory1(i);
    chi2 = chi2 + (h_data(i)-Theory2(i))^2/Theory2(i);
    
end

% determine p-values
p1= 1 - gammainc(19/2,chi1/2)/gamma(19/2);
p2 = 1 - gammainc(19/2,chi2/2)/gamma(19/2);

%output results
fprintf('p1 = %f   p2 = %f\n', p1,p2)
fprintf('the chi^2 for theory 1 is %f\n\n',chi1)
fprintf('the chi^2 for theory 2 is %f\n\n',chi2)

% create matrix for generated data
pdata = zeros(20,1000);
pdata (1,:) = 1;
m = mean(Theory1);

%generate random data fitting a ______ distribution
for i = 1:1000
   for j= 1:20
       q = ceil(20*rand());
       pdata(j,i) =  Theory1(j)*(( m^q * exp(-m) ) /factorial(q));
    
   end
end

chi1 = zeros(1,1000);
chi2 = zeros(1,1000);


%calculate chi^2 data and p-values for each randomly created data set
for i = 1:1000
   for j= 1:20
       
    chi1(i) = chi1(i) + (pdata(j,i)-Theory1(j))^2/Theory1(j);
    chi2(i) = chi2(i) + (pdata(j,i)-Theory2(j))^2/Theory2(j);
    
   end
   
      p1(i) = 1 - gammainc(19/2,chi1(i)/2)/gamma(19/2);
      p2(i) = 1 - gammainc(19/2,chi2(i)/2)/gamma(19/2);
      
end

%output results
fprintf('The mean of the pdata is: %f\n\n',mean(pdata(:,1)));
fprintf('The mean of the chi^2 distribution is: %f\n\n',mean(chi1));

%display histogram
figure(1)
hist(chi1,50)
xlabel('Chi^2 value')
ylabel('Frequency')
title('Chi^2 Distribution')