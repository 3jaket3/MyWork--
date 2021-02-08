%//////////////////////////////////////////////////////////////////////////
classdef Red_Black_Tree_Lines < handle
    % Balanced Binary search tree
    % This is a balanced BST created for the Intersection of lines problem
    
    properties
     Root % start of the tree
     count; % number of segments in the tree
     SweepLine % current sweepline 
    end
    
    methods
        % constructor class for the tree
        function obj = Red_Black_Tree_Lines(sweepline)
            obj.Root = [];
            obj.count = 0;
            obj.SweepLine = sweepline;

        end
    

          
%//////////////////////////////////////////////////////////////////////////
% red black tree insert method
        function [output,z] = Insert(obj, z)
            % calculate the Point where the segment intersects the
            % sweepline
            
            
            
            obj.count = obj.count+1; % increase the count
            y = []; % create empty object
            x = obj.Root; % set x to root of tree
            obj.Root = x;
            
            while(~isempty(x)) % loop while x isnt empty to find location for insertion
                y = x; % save original x
                if (z.CompareTo(x, obj.SweepLine) > 0) % move left or right based on item value
                    x = x.Left;
                else
                    x = x.Right;
                end
                
            end
  
            if ( isempty(y)) % if tree is empty make z the root
                obj.Root = z;
                output = obj;
                return
            elseif ( z.CompareTo(y, obj.SweepLine) > 0) % else insert Noded on left or right
                y.Left = z;
                z.Parent = y;
            else
                y.Right = z;
                z.Parent = y;
            end
            
            z.Left = []; % set children to empty
            z.Right = [];
            z.C = Color.Red; % color node red
            
            if(~isempty(z.Parent.Parent))
            RB_Rebalance(obj,z); % call rebalance function
            end
            output = obj;
            
        end
%//////////////////////////////////////////////////////////////////////////


% red black tree rebalance method

%{
    Case 1 : z's uncle is Red
    Case 2 : z's uncle is black and z is a right child
    Case 3 : z's uncle is black and z is a left child
%}
        function output = RB_Rebalance(obj,z)
           while(getColor(z.Parent) == Color.Red) % while parent is red
              if(z.Parent.equals(z.Parent.Parent.Left)) % if z's parent is the left child of its parent
                 y = z.Parent.Parent.Right; % left y be the uncle
                 if(getColor(y) == Color.Red) % if y is red Case 1
                    z.Parent.C = Color.Black; %  % re-color z's parent and uncle back
                    y.C = Color.Black;
                    z.Parent.Parent.C = Color.Red; % set z's grandparent red
                    z = z.Parent.Parent; % make z its grandparent
                 elseif( z.equals(z.Parent.Right)) % case 2
                     z = z.Parent; % set Z to its parent
                     obj.Root = LeftRotate(obj.Root,z); % preform a left rotate
                 elseif( z.equals(z.Parent.Left)) % case 3
                     z.Parent.C = Color.Black; % recolor the parent black
                     z.Parent.Parent.C = Color.Red; % make z's grandparent red
                     obj.Root = RightRotate(obj.Root,z.Parent.Parent); % left rotate the Grandparent
                 end
              
              else % same as the above code for the opposite case z is right child of its parent
                  % same as the above code with Left and right swapped
                    y = z.Parent.Parent.Left;
                 if(getColor(y) == Color.Red)
                    z.Parent.C = Color.Black;
                    y.C = Color.Black;
                    z.Parent.Parent.C = Color.Red;
                    z = z.Parent.Parent;
                 elseif(z.equals(z.Parent.Left))
                     z = z.Parent;
                     obj.Root = RightRotate(obj.Root,z);
                 elseif( z.equals(z.Parent.Right))    
                     z.Parent.C = Color.Black;
                     z.Parent.Parent.C = Color.Red;
                     obj.Root = LeftRotate(obj.Root,z.Parent.Parent);
                 end
                  
              end
           end
           obj.Root.C = Color.Black; % color the root black
           output = obj;
        end
%//////////////////////////////////////////////////////////////////////
% Method to assist Delete function
        
% ////////////////////////////////////////////////////////////////////
function output = Delete(obj, z)
        
            obj.count = obj.count-1;
            y = z;
            y_original_color = y.C;
            
            if(isempty(z.Left))
                 x = z.Transplant(obj,z.Right);
                
            elseif( isempty(z.Right))
                x = z.Transplant(obj,z.Left); 
               
            else
                y = z.Right;
                while (~isempty(y.Left))
                    y = y.Left;
                end
                y_orignial_color = y.C;
                x = y.Right;
                if(y.Parent.equals(z))
                    x.Parent = y;
                else 
                    x = y.Transplant(obj ,y.Right);
                    y.Right = z.Right;
                    y.Right.Parent = y;
                end
                    z.Transplant(obj,y);
                    y.Left = z.Left;
                    y.Left.Parent = y;
                    y.C = z.C;
                    
                end
                
           
            if(~isa(x,'Node') )
               temp = Node([]); 
               temp.Parent = x.Parent;
               x = temp
            end
            if( y_original_color == Color.Black  && obj.count > 2)
               output = obj.DeleteFix(x); 
            end
            output = obj;
        end
%//////////////////////////////////////////////////////////////////////////
 % RB DeleteFix not need since always deleting the root and the entire tree
 

 function output = DeleteFix(obj,x)
    
     while( ~obj.Root.equals(x) && getColor(x) == Color.Black)
        if( x.equals(x.Parent.Left))
            w = x.Parent.Right;
            if(getColor(w) == Color.Red)
               w.C = Color.Black;
               x.Parent.C = Color.Red; 
               obj.Root = LeftRotate(obj.Root, x.Parent);
               w = x.Parent.Right;
            end
            if(isempty(w))
                x = x.Parent;
            elseif (getColor(w.Left) == Color.Black && getColor(w.Right) == Color.Black)
               w.C = Color.Red;
               x = x.Parent;
            elseif(getColor(w.Right) == Color.Black)
                w.Left.C = Color.Black;
                w.C = Color.Red;
                obj.Root = RightRotate(obj.Root,w);
                w = x.Parent.Right;
            else
                w.C = x.Parent.C;
                x.Parent.C = Color.Black;
                w.Right.C = Color.Black;
                obj.Root = LeftRotate(obj.Root,x.Parent);
                x = obj.Root;
            end
        else
            w = x.Parent.Left;
            if(getColor(w) == Color.Red)
               w.C = Color.Black;
               x.Parent.C = Color.Red;
               obj.Root = RightRotate(obj.Root, x.Parent);
               w = x.Parent.Left;

            end
            if(isempty(w))
                x = x.Parent;
            elseif(getColor(w.Left) == Color.Black && getColor(w.Right) == Color.Black)
               w.C = Color.Red;
               x = x.Parent;
            elseif(getColor(w.Left) == Color.Black)
                w.Right.C = Color.Black;
                w.C = Color.Red;
                obj.Root = LeftRotate(obj.Root, w);
                w = x.Parent.Left;
            else
                w.C = x.Parent.C;
                x.Parent.C = Color.Black;
                w.Left.C = Color.Black;
                obj.Root = RightRotate(obj.Root, x.Parent);
                x = obj.Root;
            end
        end 
        
     end
     x.C = Color.Black;
     output = obj;
     
 end
 
%/////////////////////////////////////////////////////////////////////////

% prints tree in sorted order smallest to largest
        function output = preorder(obj,Node)
            
            if(isa(Node, 'Node'))
            if( ~isempty(Node) )
                preorder(obj,Node.Left);
                fprintf(' %d', Node .Item);
            end
            if( ~isempty(Node.Right) )
                preorder(obj,Node.Right);
                
            end
            
            end
            output = true;
        end
      
        function output = Find(obj,x)
           
            y = obj.Root;
            
            while(~isempty(y))
               
                if( x.CompareTo(y,obj.SweepLine) < 0)
                   y = y.Right;
                elseif(x.CompareTo(y,obj.SweepLine > 0))
                    y = y.Left;
                else
                    output = y;
                    return;
                end
                
            end
            output = [];
        end
        
end
end
