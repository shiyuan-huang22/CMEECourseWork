#!/bin/bash
# Author: Shiyuan Huang sh422@ic.ac.uk
# Script: CompileReport.sh
# Description: Bash script to compile LaTeX, and save pdf output to results

pdflatex Huang_CMEE_MSc_02250317.tex
bibtex Huang_CMEE_MSc_02250317
pdflatex Huang_CMEE_MSc_02250317.tex
pdflatex Huang_CMEE_MSc_02250317.tex
evince Huang_CMEE_MSc_02250317.pdf &



rm *.aux
rm *.log
rm *.bbl
rm *.blg