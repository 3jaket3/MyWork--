N = 1000;
tol = 10^-4;
i = 1;
f1 = @(x) x^3 - 2*x^2 -5;
f2 = @(x) 3*x^2 - 4*x;
po = 2.5;
while(i<N)
   
    p = po - f1(po)/f2(po);
    if (abs(p-po) <tol)
        fprintf('the solution is x = %f',p)
        break; 
    end  
    i = i+1;
    po=p;
    
end
