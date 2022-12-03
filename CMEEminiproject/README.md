# Miniproject

## Description

This directory contains all scripts for Miniproject

## Languages

R, Latex, Shell

## Dependencies

For some scripts in this directory, packages [minpack.lm], [ggplot2] are required. 

**Installation:**
```R
install.packages(c("minpack.lm", "ggplot2"))
```

```

[LaTeX] installation is also required. Please run following **bash** script in Terminal for installation:
```bash
sudo apt install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```
## Installation

To use scripts in this directory clone the repository.

```bash
git clone git@github.com:shiyuan-huang22/CMEECourseWork.git
```

## Project structure and Usage 


- **data_wrangle.R:** R script for data wrangle.

- **modelfitting.R:** R scripts for model fitting, model visualization and calculation of AICc, BIC, R squared.

- **analysis.R:** R scripts for counting best model, calculation of Akaike weight and visualization of AICc, BIC, Akaike weight, R squared results. 

- **model_def.R:** Source code for Logistic model and Gompertz model.

- **stat_cal.R:** Source code for RSS, AICc and BIC calculator. NonLogRSS for log scale to linear scale and LMRSS for linear scale.

- **ref.bib:** References of Miniproject report.

- **Miniproject.tex:** Latex script for Miniproject report writting.

- **CompileReport.sh:** Shell script for compiling Miniproject report.

- **run_Miniproject.sh:** Shell script for running the whole Miniproject. 




## Author name and contact

Name: Shiyuan Huang

Email: sh422@ic.ac.uk