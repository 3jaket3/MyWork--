// 2/9/2019
// jaketully
// this program takes a txt file and reverses the string

#include <stdio.h>
#include <stdlib.h>

// main program
int main(int argc, char *argv[])
{

// check to see if there are enough input arguments
if(argc < 3)
{
	printf("please enter the input file as arg 1 and output file as arg 2");
}


FILE *fp,*fp2; // create file pointers 

fp = fopen(argv[1], "r"); // open input file read only

if( fp == NULL) // make sure file was opened succesfully
{
	puts(" could not open file"); // output error message
	exit(0); 
}

fseek(fp,0,SEEK_END); // use fseek to move to end of file

int num_chars = ftell(fp); // get the pointer possition using ftell

fp2 = fopen(argv[2],"w+"); // open output file if it doesnt exist create it as write only

if(fp2 == NULL) // make sure file was created succesfully
{
	puts(" could not create file"); // output error message
}

// this loop iterates for each character in the input file
for( int i = 0; i < num_chars -1; i++)
{
	fseek(fp,-2,SEEK_CUR); // move the pointer from its current position two characters back
	fprintf(fp2,"%c",fgetc(fp)); // write the character to the output file retrived by fgetc(fp)
} 
fprintf(fp2,"%c",'\n'); // put a new line character at the end of the file

fclose(fp); // close input file
fclose(fp2); // close output file

return 0; // exit main program
}