#!/usr/bin/env python3
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'


"""Modified cfexercises1.all the foo_x functions taken arguments from the user 
(like the functions inside control_flow.py)"""

## Imports ##
# module to interface our program with the operating system
import sys

"""Square root of x"""
def foo_1(x=2):
    """Find square root of x"""
    return f"The square root of {x} is : {x ** 0.5}"

"""Find the larger number"""
def foo_2(x=2, y=3):
    if x > y:
        return f"The larger number is :{x}"
    return f"The larger number is :{y}"

"""Rank numbers as an increasing order"""
def foo_3(x=2, y=3, z=4):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return f"Increased order of the sequence is :{[x, y, z]}"

"""Find the factorial of x"""
def foo_4(x=5):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return f"The factorial of {x} is {result}" 

"""A recursive function to calculate the factorial of x"""
def foo_5(x=5): 
    if x == 1:
        return 1
    return x * foo_5(x-1)

"""Find the factorial of x"""    
def foo_6(x=5): 
    facto = 1
    y = x
    while x >= 1:
        facto = facto * x
        x = x - 1
    return f"The factorial of {y} is {facto}" 
 

def main(argv):
    """Main entry point of the program"""
    print(foo_1(2))
    print(foo_2(77,8))
    print(foo_3(101,11,112))
    print(foo_4(2))
    print(f"The factorial of 4 is {foo_5(4)}")
    print(foo_6(5))
    return 0

if __name__ == "__main__":
    """Make sure the main function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)






