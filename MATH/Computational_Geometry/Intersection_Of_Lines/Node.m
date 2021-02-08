% Red-Black-Tree Node
% Jake Tully 1/18/2021


%//////////////////////////////////////////////////////////////////////////
% Node Class
classdef Node < handle 
    properties
       Left % left node
       Right % right node
       Parent % parent node
       C % color of node
       Item % item stored in the node
      
    end
    
    methods

        function obj = Node(item) % constructor of for the node class
            obj.C = Color.Black; % node is initially black
            obj.Item = item; % set the item contained in the node
        end
        
        function output = equals(obj,x) % equals method used to safely check for equality in the case where a node is empty
            
            if(isempty(x) || isempty(obj)|| isempty(x.Item)||isempty(obj.Item)) % if either the object calling or passed is empty return false
               obj = false; 
            elseif( x.Item.X1 == obj.Item.X1 && x.Item.Y1 == obj.Item.Y1) % if the segments contain the same upper point
                obj = true;
            else % not empty and not the same upper point
                obj = false;
            end
            output = obj;
            
        end
        %//////////////////////////////////////////////////////////////////////////
% red black tree right rotate function for balancing tree
 % left rotate method for balancing tree
 %{
             Y                          X
            / \    right rotate        / \
           A   X   <-----------       Y   C
              / \                    / \
             B   C                  A   B
  
 %}
         function output = LeftRotate(tree, x) % left rotate assisting the rebalancing of the tree
             % method is in the node class such that the node is modified
             % on call ( Node is a Handle class) explanation for left and
             % right is contained above 
            y = x.Right;
            temp = y.Left;
            y.Left = x;
            x.Right = temp;
            if(~isempty(x.Right))
               x.Right.Parent = x; 
            end
            
            y.Parent = x.Parent;
            
            
            if(isempty(y.Parent))
               tree = y; 
            elseif(x == x.Parent.Left)
                x.Parent.Left = y;
            else
               x.Parent.Right = y;
            end
            x.Parent = y;
            output = tree;
         end
 
        function output = RightRotate(tree,x)
            y = x.Left;
            temp = y.Right;
            y.Right = x;
            x.Left = temp;
            if(~isempty(x.Left))
               x.Left.Parent = x; 
            end
            y.Parent = x.Parent;
            
            
            if(isempty(y.Parent))
               tree = y; 
            elseif(x == x.Parent.Left)
                x.Parent.Left = y;
            else
               x.Parent.Right = y;
            end
            
            x.Parent = y;
            
            output = tree;
        end
         
        function output = Transplant( obj, tree, v)
            % transplant function used to delete nodes
            if (isempty(obj.Parent))
                tree.Root = v;
            elseif ( obj == obj.Parent.Left )
                obj.Parent.Left = v;
            else
                obj.Parent.Right = v;
            end
            
            v.Parent = obj.Parent;
        
            output = v;
        end
        
        function output = getrightneighbor(x)
         % method to find the right neighbor of a node if it exists
         % first we look for the right child's leftmost node
         % if there is no right child then we move up the tree until we
         % find a parent that is a left child if no such node exists then x
         % is the leftmost node in the tree
            if(~isempty(x.Right)) % if x has a right child
               x = x.Right; % set x to right child
               while(~isempty(x.Left)) % if the right child has a left child move left until 
                   % find node x's leftmost node of right child
                  x = x.Left; 
               end
               output = x;
               return
            else % there is no right child 
                while(~isempty(x.Parent)) % move up the tree until at the root
                   if(x.equals(x.Parent.Left)) % x is left child
                      output = x.Parent;
                      return
                   else
                       x = x.Parent;
                   end
                end
            end
            output = [];
        end
        
        function output = getleftneighbor(x)
            % get leftneighbor is the same as rightneighbor  with left and
            % right exchanged
            
            if(~isempty(x.Left))
               x = x.Left;
               while(~isempty(x.Right))
                  x = x.Right; 
               end
               output = x;
               return
            else
                while(~isempty(x.Parent))
                   if(x.equals(x.Parent.Right)) % x is left child
                      output = x.Parent;
                      return
                   else
                       x = x.Parent;
                   end
                end
            end
            
            output = [];
        end
        
        function [output] = CompareTo(obj, z, SweepLine)
            
            m = (z.Item.Y2 - z.Item.Y1)./(z.Item.X2 - z.Item.X1);
            b = z.Item.Y1 - m.*z.Item.X1;
            zPOI = (SweepLine - b)./ m;
            
            m = (obj.Item.Y2 - obj.Item.Y1)./(obj.Item.X2 - obj.Item.X1);
            b = obj.Item.Y1 - m*obj.Item.X1;
            objPOI = (SweepLine - b)./m;
            
            if(objPOI < zPOI)
               output = 1;
            elseif(objPOI > zPOI)
                output = -1;
            else
                output = 0;
            end
            
            
end
        
    end
end
