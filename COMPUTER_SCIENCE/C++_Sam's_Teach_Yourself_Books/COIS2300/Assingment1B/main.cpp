#include <iostream>
#include <limits>

using namespace std;

typedef std::numeric_limits<double> dbl;

double dividedouble(double x, double y)
{
    return x/y;
}

float dividefloat(float x, float y)
{
    return x/y;
}

double loopdecimal()
{
    double x = 0;
    for(int i = 0; i < 1000000; i++)
    {
        x += 0.000001;
    }
    return x;
}

float loopfloat()
{
    float x = 0;
    for(int i = 0; i < 1000000; i++)
    {
        x += 0.000001;
    }
    return x;
}

int main()
{
    double x = 1;
    double y = 3;
    float x1 = 1;
    float y1 = 3;
    cout.precision(dbl::max_digits10);
    cout << "the division for doubles is " << fixed <<dividedouble(x,y) << endl;
    cout << "the division for doubles is " << dividefloat(x1,y1) << endl;
    cout << "sum loop double is " << loopdecimal() << endl;
    cout << "sum loop float is " << loopfloat() << endl;

}
