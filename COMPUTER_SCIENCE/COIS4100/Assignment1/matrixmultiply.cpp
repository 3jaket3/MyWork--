// matrix multiply 1/22/2019
// jake tully
// this program multiplies two martrix

#include <iostream>
#include <omp.h>
#include <ctime>
#include <cstdlib>
using namespace std;


/*
 matrix a is multiplied by matrix b and stored in c
 assumes square matrix 
 n is size of the matrix
*/
void multiply(double *a, double *b, double *c,int n)
{
	double first;
	double second; 



	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
		{
			*(c+i*n+j) = 0;
			for(int k = 0; k<n; k++)
			{
				 first = *(a+i*n+k); // calculate memory address a
				 second = *(b+k*n+j); //calculate memory address b
				*(c +i*n +j)+= first * second; // multiply and add to location in c
			}
		}
	}

	return;
}

void print(double * p, int n)
{

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
		{
			std::cout << *(p +i*n + j) << " "; // print memory address
		}

		std::cout << endl;
	}
}

void initialize(double * p, int n)
{

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
		{

			*(p + i*n + j) = (double) (rand() % 10);
			
		}
	}
}


int main()
{

	double a[500][500];
	initialize(&a[0][0],500);

	double b[500][100];
	initialize(&b[0][0],500);

	double c[500][500];

	clock_t begin = clock();

	multiply(&a[0][0], &b[0][0],&c[0][0],500);
	
	clock_t end = clock();

	double elapsed_secs = double(end-begin) / CLOCKS_PER_SEC;
	printf("\nTime elapsed: %.8f\n",elapsed_secs);
	
	return 0;
}