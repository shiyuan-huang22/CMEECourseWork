# Author: Shiyuan Huang (sh422@ic.ac.uk)
# Script: PP_Dists.R
# Created: Nov 2022

rm(list = ls())
require(dplyr)

MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dplyr::glimpse(MyDF)
x <- unique(MyDF$Type.of.feeding.interaction)

#convert mass from mg to g
MyDF$Prey.mass[which(MyDF$Prey.mass.unit == "mg")] <- MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000

#predator subplot
pdf("../results/Pred_Subplots.pdf")
par(mfcol=c(5,1))
for(i in x){
  plot(density(log(MyDF$Predator.mass[which(MyDF$Type.of.feeding.interaction==i)])),
  xlab="log(predator_mass)",ylab="density",main=i)
}
dev.off()

#prey subplot
pdf("../results/Prey_Subplots.pdf")
par(mfcol=c(5,1))
for(i in x){
    plot(density(log(MyDF$Prey.mass[which(MyDF$Type.of.feeding.interaction==i)])),
    xlab="log(prey_mass)",ylab="density",main=i)
}
dev.off()

#ratio subplot
pdf("../results/SizeRatio_Subplots.pdf")
par(mfcol=c(5,1))
for(i in x){
  ratio <- log(MyDF$Prey.mass[which(MyDF$Type.of.feeding.interaction==i)] / MyDF$Predator.mass[which(MyDF$Type.of.feeding.interaction==i)])
  plot(density(ratio),xlab="log(ratio)",ylab="density",main=i)
}
dev.off()

#pp results
results <- matrix(NA,7,5)
rownames(results) <- c("Feeding type", "Mean of log(Predator_mass)", "Median of log(Predator_mass)", 
"Mean of log(Prey_mass)", "Median of log(Prey_mass)","Mean of log(Ratio)", "Median of log(Ratio)")
results[1,] <- c("insectivorous","piscivorous","planktivorous","predacious","predacious/piscivorous")
results[2,] <- tapply(log(MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, mean)
results[3,] <- tapply(log(MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, median)
results[4,] <- tapply(log(MyDF$Prey.mass),MyDF$Type.of.feeding.interaction, mean)
results[5,] <- tapply(log(MyDF$Prey.mass),MyDF$Type.of.feeding.interaction, median)
results[6,] <- tapply(log(MyDF$Prey.mass/MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, mean)
results[7,] <- tapply(log(MyDF$Prey.mass/MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, median)
results
write.csv(results,"../results/PP_Results.csv")
