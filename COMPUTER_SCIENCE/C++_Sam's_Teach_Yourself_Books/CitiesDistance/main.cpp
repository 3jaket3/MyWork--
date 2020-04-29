#include <iostream>
#include <math.h>
using namespace std;

class Point
{
public:
    Point(int newX, int newY){ x = newX; y = newY;}
    ~Point();
    int getX() {return x;}
    int getY() {return y;}
    void setX(int newX) {x = newX;}
    void setY(int newY) {y = newY;}
private:
    int x;
    int y;
};

class Line
{
public:
    Line(Point p1, Point p2) {pointOne = p1; pointTwo = p2;}
    ~Line();
    Point getPointOne(){return pointOne;}
    Point getPointTwo(){return pointTwo;}
    void setPointOne(Point newPoint){pointOne = newPoint;}
    void setPointTwo(Point newPoint){pointTwo = newPoint;}
    int getLength();
private:
    Point pointOne;
    Point pointTwo;
};

int Line::getLength()
{
    int x1 = pointOne.getX();
    int y1 = pointOne.getY();
    int x2 = pointTwo.getX();
    int y2 = pointTwo.getY();

    int length = sqrt(pow((x1-x2),2) + pow((y1-y2),2));

    return length;
}



int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
