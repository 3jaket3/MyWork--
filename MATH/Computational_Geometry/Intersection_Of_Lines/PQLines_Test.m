clear 
clc

numlines = 6;
maxlength = 20;
PQ1 = PriorityQueueLines(100);


X = zeros(numlines,2);
Y = zeros(numlines,2);
Lines = Line.empty(numlines,0);
for i=1:numlines
  
    L = Line(maxlength);
    Lines(i) = L; 
    PQ1 = PQ1.Add(L);

    X(i,1) = L.X1;
    Y(i,1) = L.Y1;
    X(i,2) = L.X2;
    Y(i,2) = L.Y2;
    
    hold on
    figure(1)
    plot(X(i,:),Y(i,:));
    legend({'Line'})
   
   
end

while( PQ1.count > 0)
   
    EP = PQ1.Front();
    fprintf('EventPoint %f\n',EP.Y1)
    PQ1 = PQ1.Remove();
end