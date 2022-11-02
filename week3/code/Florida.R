# Author: Shiyuan Huang (sh422@ic.ac.uk)
# Script: Florida.R
# Created: Nov 2022

rm(list = ls())#clear out workspace
load("../data/KeyWestAnnualMeanTemperature.RData")

View(ats)

#Plot Temperature in key west,Florida
pdf("../results/FloridaPlot1.pdf")
plot(ats, main = "Temperature in key west,Florida")
dev.off()

temp_cor <- cor(ats$Temp, ats$Year)
temp_cor

i <- length(ats$Year)
cor_of_random = c()


# generate corr coeffs from the 1000 random samples
for(n in 1:1000){
    temp_random <- sample(ats$Temp, i)
    x = cor(temp_random, ats$Year)
    cor_of_random = c(cor_of_random, x)
}

# Compare the random coefficient correaltion 
pdf("../results/FloridaPlot2.pdf")
hist(cor_of_random, xlab = "Random correlation coefficients", main = "Permutation analysis")
dev.off()

pdf("../results/FloridaPlot3.pdf")
plot(cor_of_random, ylab = "Random correlation coefficients", main = "Year ~ Temperature in Florida")
dev.off()

#Calculating p-value
pvalue = sum(cor_of_random > temp_cor) / 1000

