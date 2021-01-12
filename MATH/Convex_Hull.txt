% CONVEX HULL ALGORITHM O((n+i)longn)
clear
clc
% This algoritm takes a randomly generated set of points and finds the
% convex hull

%Jake Tully 1/11/2021

%PROBLEM CREATION ////////////////////////////////////////////////////////
% generate 20 random numbers between 1 and 21 for the X & Y co-ordinate
X = rand(1, 20)*20+1;
Y = rand(1, 20)*20+1;

%plot points
figure(1)
scatter(X,Y)
title('Random points With Drawn Convex Hull')
xlabel('X Co-ordinate')
ylabel('Y Co-ordinate')
hold on
% UPPER HULL ///////////////////////////////////////////////////////////
% sort arrays im Asending order of x values
[X, XSortedOrder]=sort(X);
Y = Y(XSortedOrder);

% Create list containing first 2 points
 Xupper = [X(1),X(2)];
 Yupper = [Y(1),Y(2)];
 Xlower = [];
 Ylower = [];
 
% start for loop at n = 3 and add X(n)/Y(n) 
for n=3:length(X)
    % add point to upper hull points list
    Xupper(length(Xupper)+1) = X(n);
    Yupper(length(Yupper)+1) = Y(n);
    
    % create Matrix of last three points for cross product
    A = [ Xupper(length(Xupper)-2),Xupper(length(Xupper)-1),Xupper(length(Xupper));
          Yupper(length(Yupper)-2),Yupper(length(Yupper)-1),Yupper(length(Yupper));
          1,1,1];
    % if Lupper size is greater than 2 and the last 3 points dont make a right turn
    % using cross product to determine left or right turn
    while (det(A) > 0) && ( length(Xupper) > 2)
        % if last 3 points are concave remove midpoint from list 
        % and add that point to the lower hull list
        Xlower(length(Xlower)+1) = [Xupper(length(Xupper)-1)];
        Ylower(length(Ylower)+1) = [Yupper(length(Yupper)-1)];
        Xupper(length(Xupper)-1) = []; % delete midpoint
        Yupper(length(Yupper)-1) = [];
        
        % if more that 2 points remain update matrix for cross product
        if( length(Xupper) > 2 )
            A = [ Xupper(length(Xupper)-2),Xupper(length(Xupper)-1),Xupper(length(Xupper));
          Yupper(length(Yupper)-2),Yupper(length(Yupper)-1),Yupper(length(Yupper));
          1,1,1];
        end
    end
end
%LOWER HULL //////////////////////////////////////////////////////////

% sort arrays im Asending order of x values to insure lower hull is
% properly sorted and create new points list
[Px, XlowerSortedOrder]=sort(Xlower);
Py = Ylower(XlowerSortedOrder);

% add start and end point of upper hull to lower hull list
Px = [Xupper(1), Px, Xupper(length(Xupper))];
Py = [Yupper(1), Py , Yupper(length(Xupper))];


% place last two points in lower hull list
Xlower = [];
Ylower = [];
Xlower =[Px(length(Px)),Px(length(Px) -1)];
Ylower =[Py(length(Py)),Py(length(Py)-1)];

% iterate form last three points to start point of upper hull    
for i=length(Px)-2:-1:1
    % add point to lower hull list
    Xlower(length(Xlower)+1) = Px(i);
    Ylower(length(Ylower)+1) = Py(i);
     
    % create matrix for the cross product
    A = [ Xlower(length(Xlower)),Xlower(length(Xlower)-1),Xlower(length(Xlower)-2);
    Ylower(length(Ylower)),Ylower(length(Ylower)-1),Ylower(length(Ylower)-2);
    1,1,1];
        
    % if Lupper size is greater than two and the last three points dont make a right turn
    % using the cross product to determine if the last three points are
    % concave
    while(det(A) < 0) && ( length(Xlower) > 2) 
        % if the last three points are concave remove midpoint
        Xlower(length(Xlower)-1) = []; % delete midpoint
        Ylower(length(Ylower)-1) = [];
        
        % if more than 3 points in lower hull update the cross porduct
        % matrix
        if( length(Xlower) > 2 )
            A = [ Xlower(length(Xlower)),Xlower(length(Xlower)-1),Xlower(length(Xlower)-2);
            Ylower(length(Ylower)),Ylower(length(Ylower)-1),Ylower(length(Ylower)-2);
            1,1,1];
        end
    end 
end
% remove duplicate start and end points from the lower hull list
Xlower(1) = [];
Ylower(1) = [];
Xlower(length(Xlower)) = [];
Ylower(length(Ylower)) = [];

% append the lower hull to upper hull to create the hull list
Hullx = [Xupper,Xlower];
Hully = [Yupper,Ylower];

% plot each set of point in the hall in a clockwise order to visulually
% demonstrate the results
%///////////////////////////////////////////////////////////////////
for i=1:length(Hullx)-1
x = [ Hullx(i),Hullx(i+1)];
y = [ Hully(i),Hully(i+1)];
plot(x,y)
pause(1)          
end
        
x =[ Hullx(1),Hullx(i+1)];
y =[ Hully(1),Hully(i+1)];
plot(x,y)
hold off
  
%////////////////////////////////////////////////////////////////////////
%PROGRAM END

