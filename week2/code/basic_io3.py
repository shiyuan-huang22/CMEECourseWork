#!/usr/bin/env python3

__appname__ = 'basic_io3.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""Example of storing object"""

##################
#stoting object
##################
#to save an object (even complex)for later use
my_dictionary = {"a key": 10, "another key": 11}

import pickle

f = open('../sandbox/testp.p','wb')
pickle.dump(my_dictionary, f)
f.close()

##load the data again
f = open('../sandbox/testp.p','rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)