#!/bin/bash
# Author: Shiyuan sh422@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenate the contents of two files
# Arguements: 1 + 2 -> 3
# Date: Oct.2022


if [ -z "$1" -o -z "$2" ];then
  echo "Please enter two files as your input"
elif [ -z "$3" ];then
  echo "Please enter your output file"
else  
  cat $1 > $3
  cat $2 >> $3
  echo "Merged File is"
  cat $3
fi
exit