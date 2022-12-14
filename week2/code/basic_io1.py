#!/usr/bin/env python3

__appname__ = 'basic_io1.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""Example of importing data"""

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
