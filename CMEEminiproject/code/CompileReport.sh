#!/bin/bash
# Author: Shiyuan Huang sh422@ic.ac.uk
# Script: CompileReport.sh
# Description: Bash script to compile LaTeX, and save pdf output to results

pdflatex Miniproject.tex
bibtex Miniproject
pdflatex Miniproject.tex
pdflatex Miniproject.tex
evince Miniproject.pdf &



rm *.aux
rm *.log
rm *.bbl
rm *.blg