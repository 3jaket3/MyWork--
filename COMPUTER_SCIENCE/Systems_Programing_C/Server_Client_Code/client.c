// this program handles the client side
// a file will be transfered from the server to the client
// jake tully
// 3/30/2019

#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

// definitions for variable size and name
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



// main program accepting command line arguments
int main (int argc, char * argv[])
{

// file descriptors for client and server fifo
int fifo, clientfifo,serverfifo;

// check for existance of server fifo
if(access(server_name,F_OK) == -1)
{
	printf( "the server fifo does not exist... exiting");
	exit(0);
}
// check for existance of server fifo
if(access(client_name,F_OK) == -1)
{
	printf( " the client fifo does not exist... exiting");
	exit(0);
}
// check that the file name is not to large
if(sizeof(&argv[1]) > max_filename)
{
	printf(" the filename is to large ... exiting");
	exit(0);
}

// check to see if we can open the server fifo
if( (serverfifo = open(server_name,O_RDONLY)) < 0)
{
	printf("failed to open server fifo");
	exit(0);
}
//check to see if we can open the client fifo
if( (clientfifo = open(client_name,O_WRONLY)) < 0)
{
	printf("failed to open server fifo");
	exit(0);
}

// variable for file name
char file_name[max_filename];
// copy command line parameter into file name
strcpy(file_name,argv[1]);
	
// write the filename to the  client fifo
write(clientfifo,file_name,max_filename);

// variable to hold packet info
char buffer[buffer_size];
// create packet variable
struct packet * p1 = malloc(sizeof(*p1));
struct packet sizep1; // to use in size of
// file descriptor for output file
int fd;

// check to see if we can open the output file and or create it
if ( (fd = open("lab6_sourcefile_copy",O_WRONLY|O_CREAT,0666)) ==-1)
{
	printf("could not create lab6_sourcefile_copy\n");
}

// while successful reads from the server fifo
while(read(serverfifo,p1,sizeof(sizep1)) >0)
{
	// print the number of bytes recieve by a packet
	printf("received packet of %d bytes\n", p1->num_bytes);
	// copy the date from the packet to a buffer
	strcpy(buffer,p1->data);
	// write the data to a output file
	write(fd,buffer,p1->num_bytes);

	// if we recive a packet smaller than buffer size end of file
	if(p1->num_bytes < buffer_size)
	{
		break; // exit loop
	}

}
// create terminate message
char message[message_size] = "file transfered successfull terminating client\n";

// write terminate message to client fifo
write(clientfifo,message,message_size);


exit(0);
return 1;





}