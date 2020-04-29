function [ chi ] = list( m, VarName2,Frequency )

for k=1:length(m)
    
chi(k)=chisquared(m(k),VarName2,Frequency)
end

