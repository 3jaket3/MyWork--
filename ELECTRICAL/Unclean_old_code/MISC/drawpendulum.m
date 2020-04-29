function drawpendulum(time,theta,x)

if nargin==2
% If x was not passed, just set x to a vector of zeros
x = zeros(1,length(theta));
end
% Calculate the time different between subsequent time samples
timediff=[diff(time)];
% Limit the refresh to about 10 per second
skip=ceil(0.1*length(time)/(time(end)-time(1)));
figure(1); clf; hold on;
axis([min(x)-2, max(x)+2, -1.1, 1.1]);
for i=1:skip:length(theta)-1
h1=plot(x(i)+sin(theta(i)), cos(theta(i)), 'o');
h2=line(x(i)+[0 sin(theta(i))], [0 cos(theta(i))]);
pause(timediff(i));
drawnow;
delete(h1); delete(h2);
end

end