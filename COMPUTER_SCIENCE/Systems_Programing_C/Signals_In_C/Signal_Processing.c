// this lab will demonstrate knowledge of signal proccessing in unix
// it will contain 3 signal functions
// jake tully
// 3/17/2019

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/wait.h>

#define  MAX_SIGINT  5 // maxiumum SIGINT
int i = 0; // counter for number of times sigint has been pressed


// handler 1 counts the number of times sigint has been send if
// after the signal is sent 5 times returns to defualt
void handler_one(int signo)
{
	i++; // increament  counter
	if(i < MAX_SIGINT) // check if counter is less than max sigint
	{
		signal(SIGINT,handler_one); // reinstall the signal handler
		printf("the value of i is: %d\n",i); //output current value of the counter
	}
	else // max has been exceeded
	{
		printf("Max SIGINT has been reached\n"); // output that max is exceeded
		signal(SIGINT,SIG_DFL); // return to defualt handler
	}
}


// handler 2 for sigquit  creates a new process and that process
// sends the sigusr 1 signal to the parent process the parent waits 
// until the signal is sent
void handler_two(int signo)
{
	pid_t pid, ppid; // child pid and parent pid
	ppid = getpid(); // set parent pid to current process id
	pid = fork(); // create new process

	if (pid == 0) // i am the child
	{
		printf("--> im the child sending signal SIGUSR1\n"); // output i am the child
		kill(ppid,SIGUSR1); // send siguser 1 to parent
		exit(0); // exit normally
	}
	else
	{	int status;
		waitpid(pid,&status,0); // wait for child to finish
	}
}

// handler 3 handles the siguser1 signal and states that the program
// is over then outputs the number of times singint was sent then
// exits
void handler_three(int signo)
{
	printf("the program is over\n");
	printf("ctrl c was pressed %d times\n",i);
	exit(0);

}

// main program runs a infinite loop waiting for the signals
// sigint sigquit and sigusr1
int main()
{
	int done = 0;
	signal(SIGINT,handler_one);
	signal(SIGQUIT,handler_two);
	signal(SIGUSR1,handler_three);
	


	while(!done)
	{

		pause();
	}

}