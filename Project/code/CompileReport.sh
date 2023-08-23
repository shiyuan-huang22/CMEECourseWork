#!/bin/bash
# Author: Shiyuan Huang sh422@ic.ac.uk
# Script: CompileReport.sh
# Description: Bash script to compile LaTeX, and save pdf output to results

pdflatex Shiyuan_CMEE_MSc_02250317.tex
bibtex Shiyuan_CMEE_MSc_02250317
pdflatex Shiyuan_CMEE_MSc_02250317.tex
pdflatex Shiyuan_CMEE_MSc_02250317.tex
evince Shiyuan_CMEE_MSc_02250317.pdf &



rm *.aux
rm *.log
rm *.bbl
rm *.blg