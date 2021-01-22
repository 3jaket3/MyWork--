classdef PriorityQueue
    %PRIORITYQUEUE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        capacity
        Array
        count
    end
    
    methods
        function obj = PriorityQueue(size)
            %PRIORITYQUEUE Construct an instance of this class
            %   Detailed explanation goes here
            obj.count = 0;
            obj.capacity = size;
            obj.Array = zeros(size);
           
            
        end
        
        function output = PercolateUp(obj,i)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            child = i;
            
            
            while(child > 1)
               
                parent = floor(child/2);
                
                if(obj.Array(child) > obj.Array(parent))
                    temp = obj.Array(child);
                    obj.Array(child) = obj.Array(parent);
                    obj.Array(parent) = temp;
                    child = parent;
                else
                    output = obj;
                    return
                end
                
            end
            
            output = obj;
        end
        
        function output = PercolateDown(obj, i)
            
            parent = i;
            
            while(2 * parent < obj.count)
               
                child = 2 * parent;
                
                if(child < obj.count)
                   
                    if(obj.Array(child +1) > obj.Array(child))
                       
                        child = child+1;
                        
                    end
                end
                if(obj.Array(child) > obj.Array(parent))
                   
                    temp = obj.Array(child);
                    obj.Array(child) = obj.Array(parent);
                    obj.Array(parent) = temp;
                    parent = child;
                    
                else
                    output = obj;
                    return
                end
                
            end
            output = obj;
        end
        
        function obj = Add(obj,item)
            
            if(obj.count < obj.capacity)
               obj.count = obj.count+1;
               obj.Array(obj.count) = item;
               obj = PercolateUp(obj,obj.count);
            end
            obj = obj;
        end
        
        function obj = Remove(obj)
           
            if(obj.count > 0)
                obj.count = obj.count-1;
                obj.Array(1) = obj.Array(obj.count);
                obj = PercolateDown(obj,1);
            end
            obj = obj;
        end
        
        function output = Front(obj)
           
            output = obj.Array(1);
            
        end
        
        
    end
end

