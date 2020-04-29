// this program handles the server side 
// a file will be transfered from the server to the client
// jake tully
// 3/30/2019

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>

// definition of variables
#define max_filename 80
#define buffer_size 1024
#define message_size 80
#define client_name "/home/jaketully/Documents/lab6/client_fifo"
#define server_name "/home/jaketully/Documents/lab6/server_fifo"

// structure for data transfer
struct packet 
{
	char data[buffer_size];
	int num_bytes;
};

// main program
int main()
{

// file descriptors for fifo client and server
int fifo, clientfifo,serverfifo;
// location to store filename transfered from client
char filename[max_filename];

// loop to restart after a successfull transfer
while(1)
{

// check to see if there is access to server fifo
if(access(server_name,F_OK)==-1)
{
	// if not create the fifo
	fifo = mkfifo(server_name,0777);
	if(fifo!=0) // if failed to create the fifo
	{
		printf("failed to create server fifo");
	}
}

// check to see if there is access to server fifo
if(access(client_name,F_OK)==-1)
{
	// if not create the fifo
	fifo = mkfifo(client_name,0777);
	if(fifo!=0) // if failed to create the fifo
	{
		printf("failed to create client fifo");
	}
}

// open the server fifo if failed print message and exit
if( (serverfifo = open(server_name,O_WRONLY)) < 0)
{
	printf("failed to open server fifo");
	exit(0);
}
// open the client fifo if failed print message and exit
if( (clientfifo = open(client_name,O_RDONLY)) < 0)
{
	printf("failed to open server fifo");
	exit(0);
}

// read the file name from the client fifo
read(clientfifo,filename,sizeof(filename));

int fd, nread; // file descripto and number of bytes read
char buffer[buffer_size]; // character array to store the read in data

// open the file sent from the client fifo
if((fd = open(filename,O_RDONLY)) ==-1 ) //
{
	// if failed print message
	printf("could not open source file\n");
}

int counter = 0; // counter form number of bytes
struct packet * p1 = malloc(sizeof(*p1)); //packet thing to transfer
struct packet sizep1; // to use in size of
char current[0]; // current read character
while( (nread = read(fd,current, 1)) >0) // read from the file sent by the fifo
{
	buffer[counter] = current[0]; // populate the buffer 1 character at a time
	counter++; // increament counter

	if (counter == buffer_size) // if buffer is full
	{
		strcpy(p1->data,buffer); // copy buffer into the packet
		p1->num_bytes = buffer_size; // write the number of bytes
		write(serverfifo,p1,sizeof(sizep1)); // write the packet to the server fifo
		counter = 0; // reset the counter
	}
	
}
close(fd); // close the file

if(counter != 0) // if there is a unfull packet
{
strcpy(p1->data,buffer); // copy buffer into packet
p1->num_bytes = counter; // copy number of bytes into packet
write(serverfifo,p1,1032); // write the packet to the server fifo
}



char message[message_size]; // variable to hold terminate message

read(clientfifo,message,message_size); // read terminate message from client

printf(" im the server recived message: %s",message);// print the terminate message


}

return 1;

}



