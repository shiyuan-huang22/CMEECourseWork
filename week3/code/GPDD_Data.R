# Author: Shiyuan Huang (sh422@ic.ac.uk)
# Script: GPDD_Data.R
# Created: Nov 2022

rm(list = ls())
library(maps)
load("../data/GPDDFiltered.RData")

# set this map
map(database = "world", fill = TRUE, col = "black")
# set the points on the map.
points(x = gpdd$long, y = gpdd$lat, pch = 20, col = "red")


## The sites are not evenly distributed,
## and most of these data points are located on the west coast of North America and Europe.
