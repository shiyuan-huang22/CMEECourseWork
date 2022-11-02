# Computing Week 3

## Description

This directory contains all R scripts for coursework week3

## Languages

R

## Dependencies

For some scripts in this directory, packages [tidyverse], [ggplot2], [reshape2], [maps], [dplyer], [broom] are required. 

**Installation:**
```R
install.packages(c("tidyverse", "ggplot2", "reshape2", "maps", "dplyer", "broom"))
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
<br/>

### Biological Computing in R:

- **basic_io.R:** A simple script to illustrate the input-output of R.

- **boilerplate.R:** R scripts for demonstrating R functions.

- **Florida.R:** Practical calculations and plots. 

- **Florida.tex:** Source code for the results and interpretation of the practice.

- **control_flow.R:** Demonstration control flow tool.

- **Ricker.R:** Runs the Ricker model.

- **sample.R:** An example of vectorisation involving lapply and sapply

- **TreeHeight.R:** Using the trigonometric formula, calculate the height of the tree given the distance and angle from the base to the top of each tree.

- **Vectorize2.R:** Running the stochastic Rick equation with Gaussian fluctuations. 

<br/>

### Data Management and Visualization: 

- **DataWrang.R**: Data processing of PoundHillData with reshape2 package. 

- **DataWrangTidy.R:** Data manipulation for PoundHillData with tidyverse.

- **Girko.R:** Plot Girko’s law simulation.

- **GPDD_Data.R:** Mapping GPDD.

- **MyBars.R:** Demonstration of plotting annotations. 

- **plotLin.R:** Demonstration of mathematical annotation.

- **PP_Dists.R:** Create three plots, each containing subplots of the distribution of predator mass, prey mass, and prey mass to predator mass size ratio by feeding interaction type. And calculate the mean and median of predator mass, prey mass and predator-prey size ratio by feeding type.

- **PP_Regress.R:** Plot the analysis from the subset of Predator.lifestage and calculate the regression results corresponding to the fitted line. 


## Author name and contact

Name: Shiyuan Huang

Email: sh422@ic.ac.uk