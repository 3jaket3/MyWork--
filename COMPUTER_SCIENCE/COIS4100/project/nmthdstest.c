// jake tOully
// this file test the nmthds.h file

#include "nmthds.h"
#include <math.h>
#include <stdio.h>
double fatx(double x)
{
	return x*x;
}

int main()
{
	//////////////////////////////////////////////////////
	// Eulers method
	double y[101];
	eulers(fatx,0,10,100,0,y);
	for(int i =0; i<101;i++)
	{
		printf("%f ",y[i]);
	}

	/////////////////////////////////////////////////////////
	// Runge Kutta Order Four
	RKOFOUR(fatx,0,0,100,0,y);

}