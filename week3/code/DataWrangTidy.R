# Author: Shiyuan Huang (sh422@ic.ac.uk)
# Script: DataWrangTidy.R
# Created: Nov 2022


################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
rm(list = ls())
require(tidyverse)
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")
MyData
############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)
############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = FALSE) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############

MyWrangledData=gather(TempData,key="Species",value="Count",-Cultivation,-Block,-Plot,-Quadrat)


MyWrangledData <- MyWrangledData %>%
                  mutate(across(c(Cultivation, Block, Plot, Quadrat), as.factor))

MyWrangledData <- MyWrangledData %>%
                  mutate(across(c(Count), as.numeric))
############# Exploring the data (extend the script below)  ###############

tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well 
MyWrangledData <- dplyr::as_tibble(MyWrangledData) 
MyWrangledData

glimpse(MyWrangledData) #like str(), but nicer!
filter(MyWrangledData, Count>100) #like subset(), but nicer!
slice(MyWrangledData, 10:15) # Look at a particular range of data rows

