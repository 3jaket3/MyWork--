function [ D ] = poverlap( R1,R2,A )
%poverlap returns the distance for a known area
%   Detailed explanation goes here
f=@(D)overlap(R1,R2,D)-A;

D=fzero(f,[0 2*(R1+R2)]);

end

