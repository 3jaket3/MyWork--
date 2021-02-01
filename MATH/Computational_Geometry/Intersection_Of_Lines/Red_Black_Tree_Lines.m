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
            m = (z.Item.Y2 - z.Item.Y1)./(z.Item.X2 - z.Item.X1);
            b = z.Item.Y1 - m.*z.Item.X1;
            z.POI = (obj.SweepLine - b)./ m;
            
            
            obj.count = obj.count+1; % increase the count
            y = []; % create empty object
            x = obj.Root; % set x to root of tree
            obj.Root = x;
            
            while(~isempty(x)) % loop while x isnt empty to find location for insertion
                y = x; % save original x
                if (z.POI < x.POI) % move left or right based on item value
                    x = x.Left;
                else
                    x = x.Right;
                end
                
            end
  
            if ( isempty(y)) % if tree is empty make z the root
                obj.Root = z;
                output = obj;
                return
            elseif ( z.POI < y.POI) % else insert Noded on left or right
                y.Left = z;
                z.Parent = y;
            else
                y.Right = z;
                z.Parent = y;
            end
            
            z.Left = []; % set children to empty
            z.Right = [];
            z.C = Color.Red; % color node red
            
            RB_Rebalance(obj,z); % call rebalance function
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
        function output = Transplant( obj, u, v)
            % transplant function used to delete nodes
            if (isempty(u.Parent))
                obj.Root = v;
            elseif ( u == u.Parent.Left )
                u.Parent.Left = v;
            else
                u.Parent.Right = v;
            end
            
            v.Parent = u.Parent;
        
            output = obj;
        end
% ////////////////////////////////////////////////////////////////////
function output = Delete(obj, z)
        
            obj.count = obj.count-1;
            y = z;
            if(isempty(z.Left))
                x = z.Right;
                Transplant(obj, z, z.Right);
            elseif( isempty(z.Right))
                x = z.Left;
                Transplant(obj,z, z.Left) 
            else
                y = z.Right;
                while (~isempty(y.Left))
                    y = y.Left;
                end
                x = y.Right;
                if(y.Parent == z)
                    x.Parent = y;
                else 
                    Transplant(obj, y, y.Right);
                    y.Right = z.Right;
                    y.Right.Parent = y;
                end
                Transplant(obj,z,y);
                y.Left = z.Left;
                y.Left.Parent = y;
                y.C = z.C;
            end
            output = obj;
        end
%//////////////////////////////////////////////////////////////////////////
 % RB DeleteFix not need since always deleting the root and the entire tree
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
      
end
end
