#!/bin/sh
# Author: shiyuan sh422@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2022

echo "Creating a space separated version of $1 ..."
if [ ! -f "$1" ];then
  echo "error"
exit
else
  touch ../data/new.csv
  cat $1 | tr -s "," "\t" >> new.csv
  echo "Done!"
fi