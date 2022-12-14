#!/usr/bin/env python3

__appname__ = 'using_name.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""Example of __name__ statement"""

#Filename: using_name.py

if __name__ == '__main__':
    print('This program is being run by itself!')
else:
    print('I am being imported from another script/program/module!')
print("This module's name is: " + __name__)