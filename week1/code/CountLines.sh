#!/bin/bash
#Author: shiyuan sh422@ic.ac.uk
#Script: CountLines.sh
#Description: Count lines of a file
#Arguements: none
#Date: Oct.2022


if [ -f "$1" ] ; then #If user had entered a file name
  
  NumLines=`wc -l < $1`
  echo "The file $1 has $NumLines lines"

elif [ -z "$1" ] ; then #If user did not entered a file name
 
  echo "Oops! Please enter a file name"

else #User had entered a file name but the file did not exist

  echo "Waring! Please enter a existing file"

fi
exit