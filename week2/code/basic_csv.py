#!/usr/bin/env python3

__appname__ = 'basic_csv.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""Example of loading CSV file"""

#Imports
import csv

#read a file containing:
#'species' , 'infraorder' ,'family','distribution','body mass male (kg)'
with open('../data/testcsv.csv','r') as f:

    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print("The species is", row[0])
#write a file containing only species name and body mass
with open('../data/testcsv.csv','r') as f:
    with open('../data/bodymass.csv','w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0], row[4]])