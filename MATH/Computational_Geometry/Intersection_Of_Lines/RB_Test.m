clear
clc

numlines = 6;
maxlength = 20;
PQ1 = PriorityQueueLines(100);
PQ2 =PriorityQueueLines(100);
RB = Red_Black_Tree_Lines();
X = zeros(numlines,2);
Y = zeros(numlines,2);
Lines = Line.empty(numlines,0);
for i=1:numlines
  
    L = Line(maxlength);
    Lines(i) = L; 
    L.X1 = i;
    L.X2 = i+6;
    PQ1 = PQ1.Add(L);
    RB = RB.Insert(Node(L));
    L2 = L.SwitchPoints();
    RB = RB.Insert(Node(L2));
    PQ2 = PQ2.Add(L2);
    X(i,1) = L.X1;
    Y(i,1) = L.Y1;
    X(i,2) = L.X2;
    Y(i,2) = L.Y2;
    i
    hold on
    figure(1)
    plot(X(i,:),Y(i,:));
    legend({'Line'})
   
   
end
p1 = scatter(X(:,1),Y(:,1),'x');
p2 = scatter(X(:,2),Y(:,2),'x');
legend([p1 p2], 'Upper Event Points', 'Lower Event Points')
pause(2)

%{
    resulting tree
                  7B
              /        \
            2B          9B
          /    \       /   \
        1B      4R    8B    11B
               /  \        /   \
              3B   5B     10R   12R
                     \
                      6R

%}
% deletion

% case 1 x's sibling w is red ---> Case 2 x's sibling is black and both of
% w's children are black
RB = RB.Delete(RB.find(5));
RB = RB.Delete(RB.find(1));
RB = RB.Delete(RB.find(7));
RB = RB.Delete(RB.find(11));
RB = RB.Delete(RB.find(4));
