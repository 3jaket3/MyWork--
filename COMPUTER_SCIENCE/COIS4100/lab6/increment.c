// applicative order
// jake tully

#include <time.h>
#include <stdio.h>


int increment(int n)
{
	if(n > 0)
	{
		return 1 + increment(n-1);
	}
	else 
	{
		return 0;
	}
}


int main()
{
	clock_t start, end;
	double cpu_time_used;

	start = clock();
	printf("%d\n",increment(7000));
	end = clock();

	cpu_time_used = ((double) (end-start))/CLOCKS_PER_SEC;

	printf("%f",cpu_time_used);

	return 0;
}