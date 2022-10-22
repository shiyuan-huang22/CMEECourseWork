#!/usr/bin/env python3

#############
#FILE INPUT
#############
#OPEN A FILE FOR READING
with open('../sandbox/test.txt', 'r') as f:
#use implicit for loop
#if the object is a file,py will cycle over lines
  for line in f :
      print(line)




#same example,skip blank lines
with open('../sandbox/test.txt', 'r') as f:
  for line in f :
      if len(line.strip()) > 0:
          print(line)
