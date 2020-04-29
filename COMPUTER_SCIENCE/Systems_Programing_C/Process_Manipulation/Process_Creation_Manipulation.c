// this program is to demonstarte knowledge of process creation
// and manipulation
// jake tully
// 3/11/2019

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>
#include <sys/types.h>

int main()
{
	pid_t pidA, wpid; // pid for first fork and wait return
	
	int status = 0;

	pidA = fork(); // first fork
	
	if( pidA == 0 ) // if first child
	{
		pid_t pidC; // pid for grandchild
		pidC = fork(); // first child fork
		if(pidC == 0) // if grandchild
	    {	
	    	// sleep 3 secs then execute head -n 20 lab4_jaketully
	    	sleep(3);
			execlp("head","head","-n","20","lab4_jaketully.c",(char *)NULL);
			// if it reaches this code execlp did not function properly
			printf("the call to execlp was not succesfull/n");
			exit(0);
	    }
	    else // first child
	    {
		while(waitpid(pidC,&status, WNOHANG) == 0) // wait for grandchild with no hang
		{
			// sleep 1 secs and see if grandchild has finished again
			sleep(1);
			printf("try again\n");
		}
		exit(0);
		}
	}
	else if( pidA > 0) // im the parent
	{	
		pid_t pidB; // pid for second child
		pidB = fork(); // second fork

		if( pidB == 0 ) // if second child
		{
			FILE *fp; // file pointer for opening file
			FILE *fp2; // file pointer for writing to file
			int current_char; // current character
			int counter = 0; // counter for number of bytes

			fp = fopen("home/COIS/3380/lab4_sourcefile","r"); // open source file
			fp2 = fopen("lab4_file_copy.txt","w"); // open copy file

			//while not at the end of the file read chars one by one
			while ( (current_char = getc(fp)) != EOF) 
			{
				counter++; // update counter
				
				fprintf(fp2,"%c",current_char); // write the character to the copy file

			}
			printf("--> second chile: %d bytes transfered\n",counter); // output number of bytes
		    sleep(5); // sleep 5 seconds
			exit(0);
		}
		else if( pidB > 0) // im the parent
		{
			wpid = waitpid(0,&status,0); // wait for a child to finish and store the pid of that child
			// output first child to finish
			printf("the first child to finish was %d\n",(int)wpid);

			if((int)wpid == pidA) // if child 1 finished first
			{
				// wait for child 2 to finish
				waitpid(pidB,&status,0);
				//output second child to finish
				printf("the second child to finish was %d\n",(int)pidB);
			}
			if((int)wpid == pidB) // if child 2 finished first
			{
			waitpid(pidA,&status,0); // wait for child 1 to finish
			//output that child 2 has finished
			printf("the second child to finish was %d\n",(int)pidA);
		}
		else // for failed
		{
			printf("fork failed");
		}
	}
		exit(0);
	}
	else
	{
		printf("fork failed no child\n");
	}

	

	return 0;
}