function [ ] = PlotTragectory( Xo,Yo,Xo2,Yo2,traces,Title,Xlabel,Ylabel )
cstring='rgbcmyk'; % color string

xbox = [80 80 120 120];
ybox1 = [0 40 40 0];
ybox2 = [100 60 60 100];

figure(2)
title(Title)
xlabel(Xlabel)
ylabel(Ylabel)
axis([0 200 0 100])
hold on
 plot(xbox,ybox1,'k')
  plot(xbox,ybox2,'k')

  
for n=1:traces
    diff = abs((Xo(n)-Xo2(n)));
    if diff<50
    x= [Xo(n);Xo2(n)];
    y= [Yo(n);Yo2(n)];
 plot(x,y,cstring(mod(n,7)+1))  % plot with a different color each time
    end
end

hold off
end

