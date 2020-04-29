function [ T1 ] = Time( D )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if(D<118.6775 &&  D>20.1356 )
T=@(t) Distance(t) - D;
T1=fzero(T,[30 48]);
end

if(D>118.6775 &&  D<20.1356 )
error('invalid input this function works for time between 30 and 48 minutes')
end

end

