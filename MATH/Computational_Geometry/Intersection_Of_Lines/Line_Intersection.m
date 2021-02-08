%{
Intersection of line segments Algorithm
Jake Tully 1/28/2021 

This group of files is used to find all insersections for
randomly generated line segments with closed end points
in  O( (n+i)log(n) ) time

Use of Textbook Computational Geometry Algorithms and Applications Third
Edition

Use of MIT Computational Geometry Lectures on Youtube

%}

% INITIAL PROBLEM SETUP   
%////////////////////////////////////////////////////////////////////////
clear 
clc

numlines = 20;
maxlength = 20;
PQ1 = PriorityQueueLines(100); % creation of priority Q sorted on y values
Xmap = containers.Map('KeyType','double','ValueType','double');
Ymap = containers.Map('KeyType','double','ValueType','double');
numIntersections = 0;
X = zeros(numlines,2);
Y = zeros(numlines,2);
for i=1:numlines
  
    L = Line(maxlength); % generation of random line
    PQ1 = PQ1.Add(L); % add upper end point to Queue
    PQ1 = PQ1.Add(L.SwitchPoints()); % add lower endpoint to Queue
    X(i,1) = L.X1;
    Y(i,1) = L.Y1;
    X(i,2) = L.X2;
    Y(i,2) = L.Y2;
    
    % plot lines
    hold on
    figure(1)
    plot(X(i,:),Y(i,:));
    legend({'Line'})
   
   
end
% plot endpoints
p1 = scatter(X(:,1),Y(:,1),'x'); 
p2 = scatter(X(:,2),Y(:,2),'x');

% Initialize empty tree sorted on x intersept with sweep line
RB1 = Red_Black_Tree_Lines(0);

% Algorithm Start
%////////////////////////////////////////////////////////////////////////

while( PQ1.count >= 1)
    
    EP = PQ1.Front(); % get eventpoint
    fprintf('EventPoint %f\n',EP.Y1) % print it to console
    if(EP.Y2 == 0)
        scatter(EP.X1,EP.Y1)
    end
    while(PQ1.Front().Y1 == EP.Y1 && PQ1.count >= 1) % remove any duplicate Points from the event queue
    PQ1 = PQ1.Remove(); % remove it from Queue
    end 
    %///////////////////////////////////////////////////////
    % determin type of point (upper, lower, intersection)
    
    if(EP.Y1 < EP.Y2) % lower point
        if(RB1.count > 1) % intersection is possible
            
        
        Point = RB1.Find(Node(EP.SwitchPoints()));
        if(isempty(Point))
           Point = RB1.Find(Node(EP.SwitchPoints()));
        end
        % find the Line segment of EventPoint & Left/Right Neighbors

        Left = getleftneighbor(Point); % get the node that intersects to the left of the sweep line
        Right = getrightneighbor(Point); % get the node that intersects to the right of the sweep line
        RB1 = RB1.Delete(Point);
        RB1.SweepLine = EP.Y1;
        if(~isempty(Left) && ~isempty(Right)) % if L and R exist
            NewPoint =  FindNewEventPoint(Left.Item,Right.Item); % test for Intersection
            if(~isempty(NewPoint)) % if intersection is found
                 % if that intersection is below the sweepline
                    
                    if(NewPoint.Y1 < RB1.SweepLine ) % if the newpoint is below the sweep line 
                        if(~isKey(Xmap,NewPoint.X1)|| ~isKey(Ymap,NewPoint.Y1))
                            Xmap(NewPoint.X1) = numIntersections;
                            Ymap(NewPoint.Y1) = numIntersections;
                            numIntersections = numIntersections+1;
                            PQ1 = PQ1.Add(NewPoint);
                        end
                    end % add the Point to the EventQueue
               
            end
        end
        
        end

    elseif(EP.Y2 == 0)% Intersection point is event point
        %////////////////////////////////////////////////////////
        if(RB1.count > 1) % intersection is possible
            S2 = RB1.Find(Node(EP.ILine2));
            if(isempty(S2))
                S2 = RB1.Find(Node(EP.ILine2));
            end
            RB1 = RB1.Delete(S2);
            S1 = RB1.Find(Node(EP.ILine1));
            if(isempty(S1))
               S1 = RB1.Find(Node(EP.ILine1)); 
            end
            RB1 = RB1.Delete(S1);
            
            RB1.SweepLine = EP.Y1-0.001;
            [RB1, S2] = RB1.Insert(Node(S2.Item)); % insert s2 back into the tree
            [RB1, S1] = RB1.Insert(Node(S1.Item)); % insert s2 back into the tree
            % get left and right neighbor of the intersection point 
            Right = getrightneighbor(S1); 
            Left = getleftneighbor(S2);
            
            if(~isempty(Left)) % if left neighbor exists
                
                NewPoint =  FindNewEventPoint(Left.Item,S2.Item); %check for intersection between s1 and right neighbor
                if(~isempty(NewPoint)) % if new point is not empty
                    
                    if(NewPoint.Y1 < RB1.SweepLine ) % if the newpoint is below the sweepline
                        if(~isKey(Xmap,NewPoint.X1)|| ~isKey(Ymap,NewPoint.Y1))
                            Xmap(NewPoint.X1) = numIntersections;
                            Ymap(NewPoint.Y1) = numIntersections;
                            numIntersections = numIntersections+1;
                            PQ1 = PQ1.Add(NewPoint);
                        end
                    end
                end
            end
            
            if(~isempty(Right))
                NewPoint = FindNewEventPoint(S1.Item, Right.Item); % check for intersection between right and Segment1
                if(~isempty(NewPoint)) % if new point found
                    
                    if(NewPoint.Y1 < RB1.SweepLine ) % if newpoint intersects below the sweepline
                        if(~isKey(Xmap,NewPoint.X1)|| ~isKey(Ymap,NewPoint.Y1))
                            Xmap(NewPoint.X1) = numIntersections;
                            Ymap(NewPoint.Y1) = numIntersections;
                            numIntersections = numIntersections+1;
                            PQ1 = PQ1.Add(NewPoint);
                        end
                    end
                end
            end
            
        end
        
        %////////////////////////////////////////////////////////
    else % upper point
        %///////////////////////////////////////////////////////
        RB1.SweepLine = EP.Y1;
        [RB1, x] = RB1.Insert(Node(EP)); % insert the upper point ( new line segement into the tree
        
        
        if(RB1.count > 1) % intersection is possible
            
            Point = x;
            
            
            
            Left = getleftneighbor(Point); % find the segment that intersects to the left of the evennt segment
            Right = getrightneighbor(Point); % find the segment that intersects to the right of the event segment
            
            if(~isempty(Left)) % if there is a left segment
                NewPoint =  FindNewEventPoint(Left.Item,Point.Item); % check for intersection
                if(~isempty(NewPoint)) % if a intersection is found
                    
                    if(NewPoint.Y1 < RB1.SweepLine ) % if the intersection point is below the sweepline
                        if(~isKey(Xmap,NewPoint.X1)|| ~isKey(Ymap,NewPoint.Y1))
                            Xmap(NewPoint.X1) = numIntersections;
                            Ymap(NewPoint.Y1) = numIntersections;
                            numIntersections = numIntersections+1;
                            PQ1 = PQ1.Add(NewPoint);
                        end
                    end
                end
            end
            
            if(~isempty(Right)) % if there is a segment to the right
                NewPoint = FindNewEventPoint(Point.Item,Right.Item); % check for intersection
                if(~isempty(NewPoint)) % if intersection is found
                    
                    if(NewPoint.Y1 < RB1.SweepLine ) % if the point is below the sweepline
                        if(~isKey(Xmap,NewPoint.X1)|| ~isKey(Ymap,NewPoint.Y1))
                            Xmap(NewPoint.X1) = numIntersections;
                            Ymap(NewPoint.Y1) = numIntersections;
                            numIntersections = numIntersections+1;
                            PQ1 = PQ1.Add(NewPoint);
                        end
                    end
                end
            end
             
        end
    end
end









