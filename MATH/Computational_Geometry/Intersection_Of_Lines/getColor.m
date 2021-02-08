function output = getColor(x)
     
    
    if(isempty(x)|| ~isa(x,'Node'))
       output = Color.Black;
    else
        output = x.C;
    end
    
end


