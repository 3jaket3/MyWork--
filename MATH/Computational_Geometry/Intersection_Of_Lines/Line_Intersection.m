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
            
           RB2 = Red_Black_Tree_Lines(EP.Y1+0.001); % create sweep line just above event point
            while(RB1.count > 0) % delete all elemets and re-add to sort according to new sweepline
                if(RB1.Root.Item.Y1 > RB2.SweepLine && RB1.Root.Item.Y2 < RB2.SweepLine)
                             % intersects new sweepline
                        if(EP.Y2 == RB1.Root.Item.Y1)  %% if the root is the event point  
                            [RB2, x] = RB2.Insert(Node(RB1.Root.Item)); % insert the node into the new tree
                            RB1 = RB1.Delete(RB1.Root); % delete it from the old tree
                            Point = x; % save the line that contains the line segment
                        else
                            [RB2, x] = RB2.Insert(Node(RB1.Root.Item)); % insert the node
                            RB1 = RB1.Delete(RB1.Root); % delete the node
                        end
                    
                else % doesent intersect new sweepline
                    RB1 = RB1.Delete(RB1.Root); % delete the node
                end
            end
        % find the Line segment of EventPoint & Left/Right Neighbors

        Left = getleftneighbor(Point); % get the node that intersects to the left of the sweep line
        Right = getrightneighbor(Point); % get the node that intersects to the right of the sweep line
        
        if(~isempty(Left) && ~isempty(Right)) % if L and R exist
            NewPoint =  FindNewEventPoint(Left.Item,Right.Item); % test for Intersection
            if(~isempty(NewPoint)) % if intersection is found
                 % if that intersection is below the sweepline
                    
                    if(NewPoint.Y1 < RB2.SweepLine ) % if the newpoint is below the sweep line 
                        PQ1 = PQ1.Add(NewPoint); % add it to the event queue
                    end % add the Point to the EventQueue
               
            end
        end

        RB1 = RB2; % set new tree to be the old tree
        
        end

    elseif(EP.Y2 == 0)% Intersection point is event point
        %////////////////////////////////////////////////////////
        if(RB1.count > 1) % intersection is possible
            RB2 = Red_Black_Tree_Lines(EP.Y1-0.001); % create a new tree for the current sweepline
            S1 = []; % empty segment for the one line that created the intersection point
            S2 = []; % empty segment for the other line that created the intersection point
            while(RB1.count > 0)
                if(RB1.Root.Item.Y1 > RB2.SweepLine && RB1.Root.Item.Y2 < RB2.SweepLine) % if intersects sweep line

                    if(EP.ILine1.Y1 == RB1.Root.Item.Y1) %Node was the left segment that created the intersection point
                      
                        [RB2, x] = RB2.Insert(Node(RB1.Root.Item)); % insert the node into the new tree
                        RB1 = RB1.Delete(RB1.Root); % delete the node from the old tree
                        S1 = x; % save the node that was inserted
                    elseif(EP.ILine2.Y1 ==RB1.Root.Item.Y1) % node was the right segment that created the intersection point
                        S2 = RB1.Root; % save the secoond segment
                        RB1 = RB1.Delete(RB1.Root); % delete the node
                        % dont insert the node because it intersects the
                        % sweep line at the same point as s1
                    else 
                        [RB2, x] = RB2.Insert(Node(RB1.Root.Item)); % intersects the sweep line add to new tree
                        RB1 = RB1.Delete(RB1.Root); % delete the segment from the old tree
                    end
                else % doesnt intersect sweepline
                    RB1 = RB1.Delete(RB1.Root); % delete the segment
                end
            end
            
            % get left and right neighbor of the intersection point 
            Right = getrightneighbor(S1); 
            Left = getleftneighbor(S1);
            
            if(~isempty(Left)) % if left neighbor exists
                
                NewPoint =  FindNewEventPoint(Left.Item,S2.Item); %check for intersection between s1 and right neighbor
                if(~isempty(NewPoint)) % if new point is not empty
                    
                    if(NewPoint.Y1 < RB2.SweepLine ) % if the newpoint is below the sweepline
                        PQ1 = PQ1.Add(NewPoint); % add the point to the event queue
                    end
                end
            end
            
            if(~isempty(Right))
                NewPoint = FindNewEventPoint(S1.Item, Right.Item); % check for intersection between right and Segment1
                if(~isempty(NewPoint)) % if new point found
                    
                    if(NewPoint.Y1 < RB2.SweepLine ) % if newpoint intersects below the sweepline
                        PQ1 = PQ1.Add(NewPoint); % add the point
                    end
                end
            end

            [RB2, x] = RB2.Insert(Node(S2.Item)); % insert s2 back into the tree
            RB1 = RB2; % make new tree old tree;
            
        end
        
        %////////////////////////////////////////////////////////
    else % upper point
        %///////////////////////////////////////////////////////
        [RB1, x] = RB1.Insert(Node(EP)); % insert the upper point ( new line segement into the tree
        
        
        if(RB1.count > 1) % intersection is possible
            RB2 = Red_Black_Tree_Lines(EP.Y1-0.001); % create new tree based on new sweepline
            
            while(RB1.count > 0) % find all segements that intersect the sweepline
                if(RB1.Root.Item.Y1 > RB2.SweepLine && RB1.Root.Item.Y2 < RB2.SweepLine)
                    if(EP.Y1 == RB1.Root.Item.Y1) % if the segment is the event point
                        [RB2, x] = RB2.Insert(Node(RB1.Root.Item)); % insert the segment and store the Node
                        RB1 = RB1.Delete(RB1.Root); % delete the segment from the old tree
                        Point = x; % store the node
                    else
                       [RB2, x] = RB2.Insert(Node(RB1.Root.Item)); % segment intersects the sweepline insert into new tre
                        RB1 = RB1.Delete(RB1.Root); % delete the segement
                    end
                else
                    RB1 = RB1.Delete(RB1.Root); % segment does no intersect the sweep line delete the segment
                end
            end
            
            
            Left = getleftneighbor(Point); % find the segment that intersects to the left of the evennt segment
            Right = getrightneighbor(Point); % find the segment that intersects to the right of the event segment
            
            if(~isempty(Left)) % if there is a left segment
                NewPoint =  FindNewEventPoint(Left.Item,Point.Item); % check for intersection
                if(~isempty(NewPoint)) % if a intersection is found
                    
                    if(NewPoint.Y1 < RB2.SweepLine ) % if the intersection point is below the sweepline
                        PQ1 = PQ1.Add(NewPoint); % add the point to the event queue
                    end
                end
            end
            
            if(~isempty(Right)) % if there is a segment to the right
                NewPoint = FindNewEventPoint(Point.Item,Right.Item); % check for intersection
                if(~isempty(NewPoint)) % if intersection is found
                    
                    if(NewPoint.Y1 < RB2.SweepLine ) % if the point is below the sweepline
                        PQ1 = PQ1.Add(NewPoint); % add it to the event queue
                    end
                end
            end
            RB1 = RB2;
             
        end
    end
end









