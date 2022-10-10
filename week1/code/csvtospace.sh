#!/bin/sh
# Author: shiyuan sh422@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2022

if [[ -z "$1" ]] ;then
  printf '%s\n' "No input"
exit
else
  echo "Creating a space separated version of $1 ..."
  touch ../data/new.csv
  cat $1 | tr -s "," "\t" >> new.csv
  echo "Done!"
  exit
fi