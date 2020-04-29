// jake tully
// this file contains the start of a numerical methods language

#include <math.h>
////////////////////////////////////////////////////////////
// ORDINARY DIFFERENTIAL EQUATIONS

//////////////////////////////////////////////////////////////
// Euler's Method

void eulers(double (*f)(double), double a, double b, int N, double alpha, double y[])
{
	double h = (b-a)/N;
	double t = a;
	y[0] = alpha;

	for(int i = 1; i <=N; i++)
	{
		y[i] = y[i-1] + h* ( (*f)(t) );
		t = a + i*h;
	}
}

////////////////////////////////////////////////////////////////
// Runge Kutta Order Four

void RKOFOUR (double (*f)(double), double a, double b, int N, double alpha,double y[])
{
	double h = (b-a)/N;
	double t = a;
	y[0] = alpha;
	double Kone;
	double Ktwo;
	double Kthree;
	double Kfour;

	for( int i = 1; i <= N; i++)
	{
		Kone = h* ( (*f)(t) );
		Ktwo = h* ( (*f)(t+h/2) );
		Kthree = h* ( (*f)(t+h/2) );
		Kfour = h* ( (*f)(t+h) );
		y[i] = y[i-1] + (Kone + 2*Ktwo + 2*Kthree + Kfour)/6;
		t = a+ i*h;
	}
}

////////////////////////////////////////////////////////////////////
// LINEAR FINITE-DIFFRENCE TO BOUDARY VALUE PROBLEMS

// to approximate solution to  the boudary value problem
// y'' = p(x)y' +q(x)y + r(x)

void LFDBVP(double (*p)(double), double(*q)(double), double(*r)(double),
	double A, double B, int N, double alpha, double beta, double y[])
{
	double h = ( B- A)/(N+1);
	double x = A+h;

	double a[N+1];
	double b[N+1];
	double c[N+1];
	double d[N+1];

	a[0] = 2 + pow(h,2)*( (*q)(x) );
	b[0] = -1 +(h/2)*( (*p)(x) );
	c[0] = 0;
	d[0] = -pow(h,2)*( (*r)(x) ) + (h/2)*( (*p)(x) )*alpha;

	for( int i = 1; i < N; i++)
	{
		x = A + i*h;
		a[i] = 2 + pow(h,2)*( (*q)(x) );
		b[i] = -1 +(h/2)*( (*p)(x) );
		c[i] = -1 -(h/2)*( (*p)(x) );
		d[i] = -pow(h,2)*( (*r)(x) ); 
	}

	x = B-h;
	a[N] = 2 + pow(h,2)*( (*q)(x) );
	b[N] = 0;
	c[N] = -1 -(h/2)*( (*p)(x) );
	d[N] = -pow(h,2)*( (*r)(x) ) + (1 - h/2)*( (*p)(x) )*beta;

	double l[N+1];
	double u[N+1];
	double z[N+1];

	l[0] = a[0];
	u[0] = b[0]/a[0];
	z[0] = d[0]/a[0];

	for( int i = 1; i < N; i++)
	{
		l[i] = a[i]-c[i]*u[i-1];
		u[i] = b[i]/l[i];
		z[i] = (d[i] - c[i]*z[i-1])/l[i];
	}

	l[N] = a[N] - c[N]*u[N-1];
	u[N] = 0;
	z[N] = (d[N] - c[N]*z[N])/l[N];

	y[0] = alpha;
	y[N] = beta;
	for(int i = N-1; i >0; i--)
	{
		y[i] = z[i] -u[i]*y[i+1];
	}


}
/////////////////////////////////////////////////////////////////
// WAVE EQUATION FINITE DIFFRENCE

void WaveSolver( double (*f)(double), double (*g)(double),
	double l, double T,double alpha,int m, int N, double y[][100])
	{
		double h = l/m;
		double k = T/N;
		double lambda = (k*alpha)/h;

		for(int i = 0; i < N; i++)
		{
			y[0][i] = 0;
			y[m][i] = 0;
		}

		y[0][0] = (*f)(0);
		y[m][0] = (*f)(l);

		for( int i = 1; i < m-1; i++)
		{
			y[i][0] = (*f)(i*h);
			y[i][1] = (1 - pow(lambda,2))*( (*f)(i*h) ) 
			+ (pow(lambda,2)/2) * ( (*f)( (i+1)*h) + (*f)((i-1)*h) )
			+ k*( (*g)(i*h));
		}

		for(int j = 1; j < N-1; j++)
		{
			for( int i = 1; i < m-1; i++)
			{
				y[i][j+1] = 2*(1-pow(lambda,2))*y[i][j] 
				+ pow(lambda,2)*(y[i+1][j] + y[i-1][j]) - y[i][j-1];
			}
		}
	}