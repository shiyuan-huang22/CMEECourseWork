#!/bin/bash
# Author: shiyuan sh422@ic.ac.uk
# Script: csvtospace.sh
# Description: substitute commas in the files  
#
# Save the output into a a space separated .txt file
# Arguments: 1 -> txt delimited file
# Date: Oct 2022  

if [ -z "$1" ]; then  #If user did not enter the file name  
    echo  "Oops! No input! Please enter a file name"
else # User had entered the file name
  if [ -f "$1" ] ; then #If file entered exists
    
    if [ -s "$1" ]; then  #If the file is not empty 

      if grep -q "," "$1" ;then # If there are commas in this file

        echo "Creating a space seperated version of $1 ..."

        Filename=$(basename "$1") #remove the path 
        NewFilename="${Filename%.*}" # remove the suffix

        cat $1 | tr -s "," "\t" >> ../data/Temperatures/$NewFilename.txt
        echo "Done!"

      else #There are no commas in this file
        echo "Warning! No commas found in this file"
      fi

    else # If the file is empty
        echo "Warning! File entered is empty"
    fi

  else # If file entered does not exist
    echo "Warning! File entered does not exist"
  fi
fi
exit
