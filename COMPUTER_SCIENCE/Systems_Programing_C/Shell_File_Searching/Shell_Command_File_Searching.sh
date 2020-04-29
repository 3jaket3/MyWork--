#!/bin/bash

#jake tully january 26th 2016
#this script searches files for "authentication failure" 
# finds ip addresses on thoose lines then finds the location
# parameter 1 = input file 
# parameter 2 = output file

# this if statement checks to see if a first parameter has be entered
if [ -z $1 ] 
then
	echo please enter a intput file as parameter 1
	exit
fi


# this if statements checks to see if a first parameter has be entered
if [ -z $2 ]
then 
	echo please enter a output file as parameter 2
	exit
fi

# this sequence of commands first prints all line that contain
# "authentication failure" then seperates the fields based on a blank
# then prints the 16th entry then if there is any blank lines they are
# removed before the feil is seprated on a = and the second paramitor is
# printed this contains the ip addresses then the output is sorted
# then the unique ips are counted and sorted again be the top ten
# are directed to the file specified by parameter 2

grep "authentication failure" $1 |awk 'BEGIN {FS=" "} {print $16}'|sed -r '/^\s*$/d'|awk 'BEGIN {FS="="} {print $2}'|sort | uniq -c | sort -nr | head -10 > $2

# this sequence of commads first removes the counts then takes the top 2
# ips and reads them and passes that to wget which retrieves the url and 
# directs the output to a txt file 
# theese 2 txts files contain information about the ip addresses

awk 'BEGIN {FS=" "} {print $2}' $2 | head -2 | while read i; do wget "http://ipinfo.io/$i" -O $i.txt; done


