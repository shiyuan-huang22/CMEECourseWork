#!/usr/bin/env python3
""""This is a simple boilerplate which shows 
the structure of a python programme"""

__appname__ = 'boilerplate.py'
__author__  = 'Shiyuan (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

"""This boilerplate.py script won't take arguments or
output anything."""

## imports ##
import sys #module to interface our program with the operating system

## functions ##
def main(argv):
    """Main entry point of the program"""
    print('This is a boilerplate') #NOTE: indented using two tabs or 4 spaces
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)

