#!/usr/bin/env python3

__appname__ = 'run_fmr_R.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""This script is for running fmr.R"""

import subprocess

subprocess.Popen("Rscript fmr.R >  ../results/fmrR.Rout 2 > ../results/fmrR_errFile.Rout", shell = True).wait()

fu = open("../results/fmrR_errFile.Rout", "r")
if len(fu.read()) > 0:
    print("Run fmr.R unsucessfully!")
else:
    print("Run fmr.R sucessfully!")
    fs = open("../results/fmrR_Rout", "r")
    print(fs.read())
    fs.close()
fu.close()