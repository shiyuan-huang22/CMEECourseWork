#!/usr/bin/env python3

__appname__ = 'sysargv.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""Example of sysargv"""

import sys
print("This is the name of the script: ", sys.argv[0])
print("number of arguments: ", len(sys.argv))
print("the arguments are : ",str(sys.argv))