classdef PriorityQueueLines
    %PRIORITYQUEUE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        capacity % capacity = size of the array/ heap
        Array % Array used for the heap
        count % number of elements currently stored in the heap
    end
    
    methods
        function obj = PriorityQueueLines(size)
            %  Creating the priority queue object with a specified size
            obj.count = 0; % set count to 0
            obj.capacity = size; % set the capacity of the heap
            obj.Array = Line.empty(size,0); % create the array for the heap with specified size( code can be added to double the size of the heap if it where to overflow
           
            
        end
        
        function output = PercolateUp(obj,i)
            % Method used to maintain the heap having the Max heap property
            % when Adding a new element
            child = i; % child is the used for the current node to be copared with its parent(node above)
            
            
            while(child > 1) % while the child is not the root of the heap
               
                parent = floor(child/2); % set parent (ie 2 becomes 1, 3 becomes 1)
                
                if(obj.Array(child).Y1 > obj.Array(parent).Y1) % if the child is greater than the parent swap elements
                    temp = obj.Array(child); % swap
                    obj.Array(child) = obj.Array(parent);
                    obj.Array(parent) = temp;
                    child = parent; % make the child element the value of the parent ( move up the tree)
                else
                    output = obj; % the element has been move to its proper position and the loop can terminate
                    return
                end
                
            end
            
            output = obj; % the element has been move to the root
        end
        
        function output = PercolateDown(obj, i)
            % method used to maintain the max heap property when a element
            % is removed from the heap
            parent = i; % set the parent ( always 1 the root)
            
            while(2 * parent <= obj.count) % while not past the current count (until the bottom of the heap)
               
                child = 2 * parent; % ( chiled of parent ie ( 1 become 2)
                
                if(child +1 < obj.count) % if the right leaf of the parent is less then the capacity
                   
                    if(obj.Array(child +1).Y1 > obj.Array(child).Y1) % if ( the right child is greater then the left
                       
                        child = child+1; % select the right
                        
                    end
                end
                if(obj.Array(child).Y1 > obj.Array(parent).Y1) % if the child is greate then the parent
                    % move the parent down the tree
                    temp = obj.Array(child);
                    obj.Array(child) = obj.Array(parent);
                    obj.Array(parent) = temp;
                    parent = child;
                
                else % the parent has been moved to its correct position and the loop can be terminated
                    output = obj;
                    return
                end
                
            end
            output = obj; % the parent was moved to the bottom of the heap
        end
        
        function obj = Add(obj,item)
            
            if(obj.count < obj.capacity) % if the object fits in the heap
               obj.count = obj.count+1; % increase the count
               obj.Array(obj.count) = item; % place the item into the heap at the bottom
               obj = PercolateUp(obj,obj.count); % move it up into its proper position
            end
            obj = obj;
        end
        
        function obj = Remove(obj)
           
            
            if(obj.count > 1) % if there is more then one element in the heap
                
                
                obj.Array(1) = obj.Array(obj.count); % overwrite the top element with a bottom element
                obj.count = obj.count-1; % decrease the count
                obj = PercolateDown(obj,1); % move element that was placed in the top into the correct position
            else
                obj.count = obj.count -1; % only one element in the tree just decrease the count
            end
            obj = obj;
        end
        
        function output = Front(obj)
            % get the first element in the heap
            output = obj.Array(1);
            
        end
        
        
    end
end


