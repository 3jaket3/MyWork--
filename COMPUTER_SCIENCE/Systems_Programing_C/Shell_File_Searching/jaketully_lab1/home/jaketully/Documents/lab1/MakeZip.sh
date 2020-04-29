# Jake Tully 1/24/2019
# This script will zip a file for me
# taking in the name of the subdirectory to zip
# parameter 1 is the input of the directory you want to zip

# this if statemet checks to see if a directory was entered

if [ -z $1 ]
then
	echo please enter the name of the directory you would like to zip
	exit
fi

# this creates the zip file specified by the username and diretory
# and contains the path to the directory in the format
# zip filename pathtofile

zip ${USER}_${1}.zip /home/${USER}/Documents/${1}/*