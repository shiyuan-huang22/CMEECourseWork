#!/bin/bash
# Author: Shiyuan Huang sh422@ic.ac.uk
# Script: run_Miniproject.sh
# Description: Bash script to run the whole Miniproject scripts.

echo "Start Miniproject!"
Rscript data_wrangle.R
Rscript modelfitting.R
Rscript analysis.R
bash CompileReport.sh
echo "All Miniproject scripts done!"