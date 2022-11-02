# Author: Shiyuan Huang (sh422@ic.ac.uk)
# Script: TreeHeight.R
# Created: Nov 2022

# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"
rm(list = ls())

MyData = read.csv("../data/trees.csv", header = TRUE)
head(MyData)

Cal_TH <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))
  
    return (height)
}



treehight <- Cal_TH(MyData$Angle.degrees,MyData$Distance.m)
TH <- data.frame(MyData$Species,MyData$Distance.m,MyData$Angle.degrees,treehight)
names(TH) = c("Species","Distance.m","Angle.degrees","treehight")


write.csv(TH, file = "../results/TreeHts.csv", row.names =  FALSE)
