#!/bin/bash

echo hello this script is running on the server called $HOSTNAME
echo the current time is: `date`
echo 
TIMESTAMP= `date -I`
MYVARIABLE=${HOSTNAME}_${USER}_${TIMESTAMP}.txt
ls -lt > $MYVARIABLE
ls -lt $MYVARIABLE
