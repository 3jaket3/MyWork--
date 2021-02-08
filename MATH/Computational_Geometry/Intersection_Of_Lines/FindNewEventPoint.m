function Line1 = FindNewEventPoint(l,r)

       
            % using first degree bezier parameters we can find t
            t = ((r.X1 - l.X1).*(l.Y1 - l.Y2) - ( r.Y1 - l.Y1).*(l.X1 - l.X2))./((r.X1 - r.X2).*(l.Y1 - l.Y2) - ( r.Y1 - r.Y2).*(l.X1 - l.X2));
            
            % if t is parralell then the denominator will be 0 and t will
            % be infinite or NAN in Matlab if the intersection point falls
            % on the line segment then 0 < t < 1
            if( isnan(t)|| t > 1 || t < 0 )   % parrel line check
                Line1 = []; % if there isnt intersection on the line segment return empty
                return
            end
            
            % otherwise a intersection point has been found
            X = r.X1 + t*(r.X2 - r.X1); % determine the x co-ordinate
            Y = r.Y1 + t*(r.Y2 - r.Y1); % determine the y co-ordinate
            if( Y < l.Y2 || Y > l.Y1)  % ******redundatnt******Remove
                Line1 = [];
                return
            end
            
            

            L1 = Line(0); % create a empty new line segment
            L1.X1 = X; % store x1 
            L1.Y1 = Y; % store Y2
            L1.X2 = 0; % set x2 to 0
            L1.Y2 = 0; % set y2 to 0 such that when inserted to the event queue we know it is a intersection point
            L1.ILine1 = l; % save Intersection line 1 as the left line segment
            L1.ILine2 = r; % save Intersection line 2 as the right segment
            Line1 = L1; % set output variable to L1 the new point
            

          
end

