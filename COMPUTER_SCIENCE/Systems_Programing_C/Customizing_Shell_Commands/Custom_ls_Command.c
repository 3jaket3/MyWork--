// jaketully
// 2/19/2019
// this program produces esentially the ls command

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <time.h>
#include <dirent.h>


// this function converts the tm struct to yyyy:mm:dd h:m:s
void printTime(struct tm time)
{// cant figure out how to get this to line up to 20 spaces
	printf( "%2d:%2d:%2d %2d:%2d:%2d    ",time.tm_year+1900,time.tm_mon+1,time.tm_mday,time.tm_hour,time.tm_min,time.tm_sec);
}

// this function prints the stats for a file or directory
void stats(char * file,int iflag,int pflag,int aflag,int mflag)
{
	struct stat fileStat;	
		
		// make sure stats where retrived successfully
		if(stat(file,&fileStat) == -1)
		{
			printf("could not get stats\n");
			exit(0);
		}

	// if the inode flag is set print the inode number
	if(iflag == 1)
	{
		printf("%ld   ",(long) fileStat.st_ino );	
	}

	// if the protection flag is set print the protection
	if(pflag == 1)
	{

		

		printf( (fileStat.st_mode & S_IRUSR) ? "r" : "-");
		printf( (fileStat.st_mode & S_IWUSR) ? "w" : "-");
		printf( (fileStat.st_mode & S_IXUSR) ? "x" : "-");
		printf( (fileStat.st_mode & S_IRGRP) ? "r" : "-");
		printf( (fileStat.st_mode & S_IWGRP) ? "w" : "-");
		printf( (fileStat.st_mode & S_IXGRP) ? "x" : "-");
		printf( (fileStat.st_mode & S_IROTH) ? "r" : "-");
		printf( (fileStat.st_mode & S_IWOTH) ? "w" : "-");
		printf( (fileStat.st_mode & S_IXOTH) ? "x" : "-");
		printf("   ");
	}

	// if the last accessed flag is set print the time
	if(aflag == 1)
	{
		printTime(*localtime(&fileStat.st_atime));
	}
	// if the last modified flag is set print the time
	if(mflag == 1)
	{
		printTime(*localtime(&fileStat.st_mtime));
	}

	// print the size of the file
	printf( "%ld   ", fileStat.st_size);

	// if it is a directory put [] around the name
	if (S_ISDIR(fileStat.st_mode))
	{
		printf( "[%s]   \n",file);
	}
	else // else print the name
	{
	printf( "%s   \n", file);
	}
}

// this function print the header for the output
void header(int iflag, int pflag, int aflag, int mflag)
{
	// Inode flag
	if(iflag == 1)
	{
		printf( "%s", "I-node   "); 
	}
	//permision flag
	if(pflag == 1)
	{
		printf("%s","Permissions   " );
	}
	// last accessed flag
	if(aflag == 1)
	{
		printf("%s", "Last-access-time   ");
	}
	// last modified flag
	if(mflag == 1)
	{
		printf("%s", "Last-modified-time   ");
	}
	// print size header
	printf("%s", "Size   " );
	// print file name 
	printf("%s", "Filename\n" );

	return;
}

int main(int argc, char *argv[])
{
	
	int option = 0; // value from getopt
	int iflag = -1, pflag = -1 , aflag = -1, mflag = -1, 
	sflag = -1, bflag =-1, dflag = -1;
	// iflag = inode flag, pflag = premision flag, aflag = last access flag
	// mflag = last modified flag, sflag = file size smaller than
	// bflag = file size bigger than, dflag = include directories

	int counter = 0;

    // this while loop parses the input and sets the corresponding flags
	while ((option = getopt(argc,argv,"ipamds:b:")) !=-1)
	{
		counter++;
		switch(option)
		{
			case 'i' : iflag = 1;
				break;
			case 'p' : pflag = 1;
				break;
			case 'a' : aflag = 1;
				break;
			case 'm' : mflag = 1;
				break;
			case 's' : sflag = atoi(optarg);
				break;
			case 'b' : bflag = atoi(optarg);
				break;
			case 'd' : dflag = 1;
				break;
			default: printf("failed to parse flags");
				exit(0);
		}
	}
	
	DIR *dp; // directory pointer
	struct dirent *dir; // directory structor poiter

	// open last input argument as directory if it fails defualt to current directory
	if( (dp = opendir(argv[argc-1])) == NULL) 
	{
		fprintf(stderr, "defaulting to current directory\n");
		// check to see if directory opened properly
		if( (dp = opendir(".")) == NULL)
		{
			fprintf(stderr, "can not open dir\n" );
		}
	}
	else // if last input arg is a valid directory change to that directory
	{
	     chdir(argv[argc-1]);
	}


	// create header based on flags
	header(iflag,pflag,aflag,mflag);

	// read files from the directory
	while (( dir = readdir(dp)) != NULL)
	{

		struct stat fileStat;//file stat structure

		// get stats directory	and check that it worked
		if(stat(dir->d_name,&fileStat) == -1)
		{
			printf("could not get stats\n");
			exit(0);
		}

		// ensure entry is not a directory
		if(!S_ISDIR(fileStat.st_mode))
		{
			// if s and b flag are set
			if(sflag > -1 && bflag > -1)
			{	
				// if the file size is smaller than sflag and bigger than b flag
				if( fileStat.st_size < sflag && fileStat.st_size > bflag)
				{
					// get stats on directory
					stats(dir->d_name,iflag,pflag,aflag,mflag);
				}
				
			}
			else if( sflag > -1) // only s flag is set
			{
				// if the file is smaller than sflag
				if( fileStat.st_size < sflag)
				{
					// get stats on file
					stats(dir->d_name,iflag,pflag,aflag,mflag);
				}
			}
			else if ( bflag > -1)// only b flag is set
			{
				// if the file is bigger than b flag
				if( fileStat.st_size > bflag) 
				{
					// get stats on file
					stats(dir->d_name,iflag,pflag,aflag,mflag);
				}
			}
			else // no s or b flag get stats on file
			{
				stats(dir->d_name,iflag,pflag,aflag,mflag);
			}

		} // if it is a directory and the d flag is set process file
		else if( S_ISDIR(fileStat.st_mode) && dflag == 1)
		{
			// same logic for size filter
			if(sflag > -1 && bflag > -1)
			{
				if( fileStat.st_size < sflag && fileStat.st_size > bflag)
				{
					stats(dir->d_name,iflag,pflag,aflag,mflag);
				}
				
			}
			else if( sflag > -1)
			{
				if( fileStat.st_size < sflag)
				{
					stats(dir->d_name,iflag,pflag,aflag,mflag);
				}
			}
			else if ( bflag > -1)
			{
				if( fileStat.st_size > bflag)
				{
					stats(dir->d_name,iflag,pflag,aflag,mflag);
				}
			}
			else
			{
				stats(dir->d_name,iflag,pflag,aflag,mflag);
			}

		}


	}

	

	return 0;
}

