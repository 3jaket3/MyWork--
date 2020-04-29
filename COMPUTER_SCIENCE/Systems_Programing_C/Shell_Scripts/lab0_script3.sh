#!/bin/bash

echo hello this script is running on the server called $HOSTNAME
echo the current time is: `date`
echo 

if [ -z $1 ]; then
    echo you forgot to supply an argument on the command line
    exit 1

fi

TIMESTAMP=`date -I`
MYVARIABLE=$1_${USER}_${TIMESTAMP}.tar.gz
echo creating a backup archive: $MYVARIABLE

tar -zcvf $HOME/$MYVARIABLE $HOME/Documents/COIS3380/lab0/*.sh
