classdef Line 
    %LINE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        X1
        Y1
        X2
        Y2
        ILine1
        ILine2
    end
    
    methods
        function obj = Line(MaxLength)
            obj.X1 = rand()*MaxLength;
            obj.Y1 = rand()*MaxLength;
            obj.X2 = rand()*MaxLength;
            obj.Y2 = rand()*MaxLength;
            
            if(obj.Y1 < obj.Y2)
               
                obj = obj.SwitchPoints();
                
            end
            
            obj = obj;
            
        end
        
        function output = SwitchPoints(obj)
            temp1 = obj.Y1;
            obj.Y1 = obj.Y2;
            obj.Y2 = temp1;
            
            temp2 = obj.X1;
            obj.X1 = obj.X2;
            obj.X2 = temp2;
            output = obj;
            
        end
    end
end

