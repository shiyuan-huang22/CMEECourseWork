#!/usr/bin/env python3

__appname__ = 'basic_io2.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""Example of saving data"""

##################
#FILE OUTPUT
##################
#SAVE THE ELEMTNTS OF A LIST TO A FILE
list_to_save = range(100)
 
f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n')
f.close()