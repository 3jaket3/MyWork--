function [ A ] = overlap(R1,R2,D)
%Overlap returns the amount of overlap of two disckes given the radius and
%distance between centers


if (D>=abs(R1+R2))
  
    A=0;
    return
end

if (D<=abs(R1-R2))
    A=pi.*(min([R1 R2]))^2;
    return
end

if (D>abs(R1-R2))
    x1=(D.^2+R1^2-R2^2)/(2.*D);
    x2=D-x1;
    a1=((pi.*R1.^2)./2)-[(x1.*sqrt(R1.^2-x1.^2))+(R1.^2.*asin(x1./R1))];
    a2=((pi.*R2.^2)./2)-[(x2.*sqrt(R2.^2-x2.^2))+(R2.^2.*asin(x2./R2))];
    A=(a1+a2);
end

end
