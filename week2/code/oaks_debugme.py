#!/usr/bin/env python3
__appname__ = "oaks_debugme.py"
__author__ = "Shiyuan Huang sh422@ic.ac.uk"
__version__ = "0.0.1"

import csv
import sys
import doctest


#Define function
def is_an_oak(name):
    """ Returns True if name starts with 'quercus'
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak('Quercuss robur')
    True
    """
    return name.lower().startswith('quercus') # Missing 'u' leads to bugs 
    

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    
    f.close()#missing close() here
    g.close()
    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()