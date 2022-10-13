#!/bin/bash
# Author: shiyuan sh422@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2022

if [ -z "$1" ] ; then #If user did not enter the file name 
	echo "Oops! Please enter a file name"

else #User had entered the file name 
	if [ -f "$1" ] ; then # if the file exists
      
      if [ -s "$1" ] ; then #If the file is not empty

          echo "Creating a comma delimited version of $1"
          cat $1 | tr -s "\t" "," >> $1.csv
          echo "done!"

      else #If the file is empty
          echo "Warning! File entered is empty!"
      fi

  else #If the input file does not exist
        echo "Warning! File entered does not exist"
  fi

fi
exit
