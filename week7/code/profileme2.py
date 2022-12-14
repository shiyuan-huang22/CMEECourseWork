"""Find out what slowed down the scripts, and we did two things 
to improve the script:converted the loop to a list comprehension, 
and replaced the .join with an explicit string concatenation"""

__appname__ = 'profileme2.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

import numpy as np


def my_squares(iters):
    """Calculate squares"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_squares_numpy(iters):
    """Creates numpy of squares"""
    out = np.array(range(iters)) 
    return out ** 2

def my_join(iters, string):
    """Joining strings"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """Running two functions above"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    my_squares_numpy(x)
    return 0

run_my_funcs(10000000,"My string")