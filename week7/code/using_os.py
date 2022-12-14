#!/usr/bin/env python3

__appname__ = 'using_os.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

""" This is example of using subprocess"""

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for f in files:
        if f.startswith("C"):
            FilesDirsStartingWithC.append(f)
    for sd in subdir:
        if sd.startswith("C"):
            FilesDirsStartingWithC.append(sd)


print(FilesDirsStartingWithC[1] + " , " + FilesDirsStartingWithC[21] + " , " + FilesDirsStartingWithC[-11] + " , " + FilesDirsStartingWithC[-21] )
print("Some files and directories in my home/ that start with an uppercase 'C' had printed, we had more in list")
print("")

#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:

FilesDirsStartingWithCc = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for f in files:
        if f.startswith(("c","C")):
            FilesDirsStartingWithCc.append(f)
    for sd in subdir:
        if sd.startswith(("c","C")):
            FilesDirsStartingWithCc.append(sd)


print(FilesDirsStartingWithCc[9] + " , " + FilesDirsStartingWithCc[2] + " , " + FilesDirsStartingWithCc[-8] + " , " + FilesDirsStartingWithCc[-2])
print("Some files and directories in my home/ that start with either 'c' or 'C' had printed, we had more in list")
print("")

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

DirsStartingWithCc = []

for (dir, subdir, files) in subprocess.os.walk(home):
 
    for sd in subdir:
        if sd.startswith(("c","C")):
            DirsStartingWithCc.append(sd)


print(DirsStartingWithCc[1] + " , " + DirsStartingWithCc[3] + " , " + DirsStartingWithCc[-11] + " , " + DirsStartingWithCc[-21])
print("Some directories in my home/ that start with either 'c' or 'C' had printed, we had more in list")
print("")