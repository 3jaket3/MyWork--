clear
clc
n = 10000;
X = zeros(1,n);
Y = X;
X2 = X;
Y2 = X;

for k = 1:n
    x2 = 0;
    y2 = 0;
for i=1:length(X)
    test = rand();
   if(test < 0.333333)
      x = 1;
   elseif(test > 0.666666)
      x = -1;
   else
       x = 0;
   end 
   
   
    test = rand();
   if(test < 0.333333)
      y = 1;
   elseif(test > 0.666666)
      y = -1;
   else
       y = 0;
   end 
   
   X(i) = x;
   Y(i) = y;
   
    x2 = x2 + x;
    y2 = y2 + y;
end

    X2(k) = x2;
    Y2(k) = y2;

end
mean(X)
var(X)
figure(1)
hist(X)

figure(2)
hist(X2)
mean(X2)
var(X2)