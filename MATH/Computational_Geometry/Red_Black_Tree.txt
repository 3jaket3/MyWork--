%//////////////////////////////////////////////////////////////////////////
classdef Red_Black_Tree < handle
    % Balanced Binary search tree
    % This is a balanced BST created for the Intersection of lines problem
    
    properties
     Root 
    end
    
    methods
        
        function obj = Red_Black_Tree(root)
            obj.Root = root;
        end
 %/////////////////////////////////////////////////////////////////////////
 % left rotate method for balancing tree
 %{
             X                          Y
           /   \    left rotate        / \
          A     Y   ----------->      X   C
               / \                   / \
              B    C                A   B
  
 %}
        function output = LeftRotate(obj,x)
            y = x.Right;
            x.Right = y.Left;
            
            if( ~isempty(y.Left))
                y.Left.Parent = x;
            end
            
            y.Parent = x.Parent;
            
            if( isempty(x.Parent) )
                obj.Root = y;
            elseif ( x == x.Parent.Left)
                x.Parent.Left = y;
            else  
                x.Parent.Right = y;
            end 
            y.Left = x;
            x.Parent = y;
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
    
        function output = RightRotate(obj, x)
            y = x.Left;
            x.Left = y.Right;
            
            if(~isempty(y.Right))
                y.Right.Parent = x;
            end
            
            y.Parent = x.Parent;
            
            if( isempty(x.Parent))
                obj.Root = y;
            elseif ( x == x.Parent.Right)
                x.Parent.Right = y;
            else
                x.Parent.Left = y;
            end
            y.Right = x;
            x.Parent = y;
            output = obj;
            
         end  
%//////////////////////////////////////////////////////////////////////////
% red black tree insert method
        function output = insert(obj, z)
            y = []; % create empty object
            x = obj.Root; % set x to root of tree
            obj.Root = x;
            
            while(~isempty(x)) % loop while x isnt empty to find location for insertion
                y = x; % save original x
                if (z.Item < x.Item) % move left or right based on item value
                    x = x.Left;
                else
                    x = x.Right;
                end
                
            end
  
            if ( isempty(y)) % if tree is empty make z the root
                obj.Root = z;
            elseif ( z.Item < y.Item) % else insert Noded
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
            while ( z.Parent.C == Color.Red)
                if ( z.Parent == z.Parent.Parent.Left)
                    y = z.Parent.Parent.Right;
              
                    if (~isempty(y) )
                        if  (y.C == Color.Red) % Case 1
                            z.Parent.C = Color.Black; % Case 1
                            y.C = Color.Black; % Case 1
                            z.Parent.Parent.C = Color.Red;% Case 1
                            z = y.Parent;% Case 1
                        end    
                    elseif (z == z.Parent.Right)% Case 2
                        z = z.Parent;% Case 2
                        LeftRotate(obj,z);% Case 2
                    else
                        z.Parent.C = Color.Black; % Case 3
                        z.Parent.Parent.C = Color.Red;% Case 3
                        RightRotate(obj,z.Parent.Parent);% Case 3
                    end
                
                else % same as above with left and right exchanged
                    y = z.Parent.Parent.Left;
                    
                    if(~isempty(y))
                        if(y.C == Color.Red)
                            z.Parent.C = Color.Black;
                            y.C = Color.Black;
                            z.Parent.Parent.C = Color.Red;
                            z = y.Parent;
                        end
                    elseif ( z == z.Parent.Left )
                        z = z.Parent;
                        RightRotate(obj,z);
                    else
                        z.Parent.C = Color.Black;
                        z.Parent.Parent.C = Color.Red;
                        LeftRotate(obj,z.Parent.Parent);
                    end
                    
                end
                if (isempty(z.Parent))
                    obj.Root.C = Color.Black;
                    output = obj;
                    return;
                end
            end
                
           obj.Root.C = Color.Black;
           output = obj;
        end
%//////////////////////////////////////////////////////////////////////
% Method to assist Delete function
        function output = Transplant( obj, u, v)
            if (isempty(u.Parent))
                obj.Root = v;
            elseif ( u.Item  == u.Parent.Left.Item )
                u.Parent.Left = v;
            else
                u.Parent.Right = v;
            end
            
            v.Parent = u.Parent;
        
            output = obj;
        end
% ////////////////////////////////////////////////////////////////////
function output = Delete(obj, z)
        
            if(isempty(z.Left) && isempty(z.Right)) % z is a leaf node
                % check if right or left child
                if(z.Parent.Right == z) % cut the leaf
                    y = z.Parent;
                    z.Parent = [];
                    y.Right = []
                    
                else
                    y = z.Parent;
                    z.Parent = [];
                    y.Left = [];
                end             
                output = obj;
                return
            end
            % find and remove the node to be deleted
            y = z;
            y_Original_Color = y.C;
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
                y_Original_Color = y.C;
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
            
            
            
            if( y_Original_Color == Color.Black && y.Item ~= obj.Root.Item)
                DeleteFix(obj,x); % rebalance tree if needed
            end
            output = obj;
        end
%//////////////////////////////////////////////////////////////////////////
%{
    Case 1 : x's sibling w is red
    Case 2 : x's sibling w is black and both of w's children are black
    Case 3 : x's sibling w is black and w's left child is red and w's right
             child is black
    Case 4 : x's sibling w is black and w's right child is red
%}
        function output = DeleteFix(obj,x)
            while ( x ~= obj.Root.Item && x.C == Color.Black )
                if( x.Item ==  x.Parent.Left.Item)
                    w = x.Parent.Right;
                    if(w.C == Color.Red)% Case 1
                        w.C = Color.Black;% Case 1
                        x.Parent.C = Color.Red;% Case 1
                        LeftRotate(obj, x.Parent);% Case 1
                        w = x.Parent.Right;% Case 1
                    end
                    if(w.Left.C == Color.Black && w.Right.C == Color.Black)% Case 2
                        w.C = Color.Red;% Case 2
                        x = x.Parent;% Case 2
                    elseif( w.Right.C == Color.Black)% Case 3
                        w.Left.C = Color.Black;% Case 3
                        w.C = Color.Red;% Case 3
                        RightRotate(obj,w);% Case 3
                        w = x.Parent.Right;% Case 3
                    end
                    w.C = x.Parent.C; % Case 4 
                    x.Parent.C = Color.Black;% Case 4
                    w.Right.C = Color.Black;% Case 4
                    RightRotate(obj,X.Parent);% Case 4
                    x = obj.Root;% Case 4
                else % same as above with left and right exchanged
                    if( x.Item ==  x.Parent.Right.Item)
                        w = x.Parent.Left;
                        if(w.C == Color.Red)
                            w.C = Color.Black;
                            x.Parent.C = Color.Red;
                            RightRotate(obj, x.Parent);
                            w = x.Parent.Left;
                        end
                        if(w.Right.C == Color.Black && w.Left.C == Color.Black)
                            w.C = Color.Red;
                            x = x.Parent;
                        elseif( w.Left.C == Color.Black)
                            w.Right.C = Color.Black;
                            w.C = Color.Red;
                            LeftRotate(obj,w);
                            w = x.Parent.Left;
                        end
                    w.C = x.Parent.C;
                    x.Parent.C = Color.Black;
                    w.Left.C = Color.Black;
                    RightRotate(obj,X.Parent);
                    x = obj.Root;
                   
                    end
                end
            end
            x.C = Color.Black;
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
        
        
    end
end
