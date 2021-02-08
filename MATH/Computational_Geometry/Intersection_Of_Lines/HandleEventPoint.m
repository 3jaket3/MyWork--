function output = HandleEventPoint(p,lines,MaxLength)

    RB = Red_Black_Tree_Lines(p,MaxLength);
    RB.Insert(Node(p));
    flag = 0;
    for i=1:length(lines)
       if(lines(i).Y1 > p.Y1 && lines(i).Y2 < p.Y1)
          
        RB = RB.Insert(Node(lines(i)));   
        flag = 1;
       end
    end
    if (flag == 1)
        if(~isempty(RB.Root.Left))
            FindNewEventPoint(RB.Root.Left.Item, RB.Root.Item);
        end
        if(~isempty(RB.Root.Right))
            FindNewEventPoint(RB.Root.Right.Item,RB.Root.Item);
        end
    end
       
        
      output = RB;    
    end


