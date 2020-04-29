%{
    Airplaines Traveling

    10/9/2014   Jake Tully

    This script traces the flight of two planes and determines
    when the planes will be closest together, furthest apart
    and when they are less then 100 m apart

    it will also demonstrate the utilization of functions such as
    fminbnd and fzero

%}


t=linspace(0,60,300);

x1= 200-400*cosd(30)*(t./60);
y1= 100-400*sind(30)*(t./60);

plot(x1,y1,'r')
hold on

x2= 100*cos((450*(t/60))/100);
y2= 100*sin((450*(t/60))/100);

plot(x2,y2)
xlabel(' Plane x position ')
ylabel(' Plane y position ')
title(' Trance of planes positions')
legend('Plane 1','Plane 2')
hold off


d=sqrt((x2-x1).^2+(y2-y1).^2);
figure(2)
plot(t,d)
xlabel(' Time ')
ylabel(' Distance in Meters ')
title(' Distance Between Planes Vs. Time ')

p1=150;
 
D=@(T) Distance(T);
fprintf('The planes will be closest at %f Minutes.\n\n At this time they will be %f meters apart\n\n', fminbnd(D,0,60), Distance(fminbnd(D,0,60)))
D1=@(T) -1.*Distance(T);
fprintf ('The planes will be furthest apart in a time range between 20 and 40 minutes at %f minutes\n\n',fminbnd(D1,20,40))
D2=@(T) Distance(T)-100;
fprintf('The planes will be 100m appart at %f , %f ,%f and %f minutes.\n\n',fzero(D2,[0 10]), fzero(D2,[10 20]), fzero(D2,[30 50]), fzero(D2,[50 60]))
