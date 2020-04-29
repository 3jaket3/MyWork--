
Atomspacing = 2;
W= 200*Atomspacing;
L= 100*Atomspacing;

S= zeros(W,L);

for i= 1:(W-1)
    
 
    
for k = 1:(L-1)

    p = randi(4);
 
    if p == 2
     
   
      S(i,k) = 1;
             
    else S(i,k)= 0;
            
     
    end
    end
end
spy(S, 2)