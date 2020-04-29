#include <stdio.h>
#include <time.h>

int partition ( int array[], int low, int high)
{
	int pivot = array[high];
	int temp;
	int i = low -1;

	for( int j = low; j <= high-1; j++)
	{
		if( array[j] <= pivot)
		{
			i++;
			temp = array[i];
			array[i] = array[j];
			array[j] = temp;
		}
	}
	temp = array[i+1];
	array[i+1] = array[high];
	array[high] = temp;

	return (i + 1);

}

void quicksort(int array[], int low, int high)
{
	if( low < high)
	{
		int part = partition(array,low,high);

		quicksort(array, low, part-1);
		quicksort(array,part+1,high);
	}
}





int main()
{

	int myarray[10] = {2,4,1,6,8,3,5,9,7,10};
	clock_t begin = clock();
	quicksort(myarray,0,9);
	clock_t end = clock();

	for(int i = 0; i < 10; i++)
	{
		printf("%d ",myarray[i]);
	}
	printf("\n");

	double time = (double) (end - begin) / CLOCKS_PER_SEC;

	printf("%f\n",time);
}

