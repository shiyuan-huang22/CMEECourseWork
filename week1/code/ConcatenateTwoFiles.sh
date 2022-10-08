#!/bin/bash
if [ ! -f "$1" -o ! -f "$2" ];then
  echo "error"
  exit
else
  cat $1 > all.txt
  cat $2 >> all.txt
  echo "Merged File is"
  cat all.txt
fi