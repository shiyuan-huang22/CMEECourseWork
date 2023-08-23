# Project

## Description

This directory contains all scripts for shiyuan's MSc project

## Languages

R, Latex, Shell

## Dependencies

For some scripts in this directory, packages [rtry], [V.PhyloMaker2], [ape], [funspace], [fundiversity], [tidyr], [BAT], [dplyr], [lme4], [emmeans], [MuMIn], [ggeffects], [see], [mvabund] are required. 

**Installation:**
```R
install.packages(c("rtry", "V.PhyloMaker2", "ape", "funspace", "fundiversity", "tidyr", "BAT", "dplyr", "lme4", "emmeans", "MuMIn", "ggeffects", "see", "mvabund"))
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

### Code 

- **species_name.R:** R script to get names of species from PoundHillDist_cover.csv file.

- **traitview.R:** R scripts for traits data view and preparation for further work.

- **phylogenetic_tree.R:** R scripts for building phylogenetic tree which will be used in imputation of missing trait values

- **impute_value.R:** R script for mean calculation of trait data and imputation of missing trait data.

- **evaluation.R:** R script for assessing the trait imputations. See if including phylogenetic tree will improve our imputation.

- **functional_metric.R:** R script for visulization of functional trait space and also calculating functional diversity metric, and also fitting linear mixed model of different trait and functional diversity metric

- **predictive_models.R:** R script for building fouth coner model to make a relative abundance prediction for specific sites. And also assess the prediction with different combinations of traits and environments by RMSE and R-squared.

- **ref.bib:** References of MSc project report.

- **Shiyuan_CMEE_MSc_02250317.tex:** Latex script for MSc project thesis writting.

- **CompileReport.sh:** Shell script for compiling MSc project thesis.

### Data

- **27176.zip:** Zip file of raw trait data. Please unzip this file and use 27176.csv as raw trait data.

- **PoundHillDist_cover.csv:** CSV file of raw percentage coverage data of plant species in Pound Hill.

- **TryAccSpecies.csv:** CSV file of species records in TRY Plant Trait Database.

#### trydata

- **mytrait_data.csv:** CSV file of a more concise trait data table.

- **checknumber.csv:** CSV file of a table of counts of trait data for each species, used to check which species have missing trait values.

- **merged_df_before_imputation.csv:** CSV file of mean trait values for each species before imputation.

- **scaled_imputed_result_by_missForest_with_phylogenetic_tree.csv:** CSV file of scaled mean trait values imputed using an imputation method incorporating a phylogenetic tree.

- **unscaled_imputed_result_by_missForest_with_phylogenetic_tree.csv:** CSV file of unscaled mean trait values imputed using an imputation method incorporating a phylogenetic tree.

- **rel_abun.csv:** CSV file of a wide relative abundance data.

- **abun.csv:** CSV file of a wide abundance data.

#### phylogenetical_tree

- **species.csv:** CSV file of species with their genus and family, which will be used to build phylogenetical tree.

- **mytree.tre:** Tree file which will be used in missing trait imputation.

## Author name and contact

Name: Shiyuan Huang

Email: shiyuan.huang22@imperial.ac.uk
