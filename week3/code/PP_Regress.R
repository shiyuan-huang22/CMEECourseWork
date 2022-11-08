# Author: Shiyuan Huang (sh422@ic.ac.uk)
# Script: PP_Regress.R
# Created: Nov 2022

rm(list = ls())
require(ggplot2)
require(dplyr)
library(broom)

MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")

#convert mass from mg to g
MyDF$Prey.mass[which(MyDF$Prey.mass.unit == "mg")] <- MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000

# plot predator mass against prey mass by type of feeding and predator lifestage
pdf("../results/PP_Regress_Plots.pdf")
p = ggplot(MyDF, aes(x = Prey.mass, y = Predator.mass, colour = Predator.lifestage), geom_point(shape=I(3))) + 
    geom_smooth(method = "lm", fullrange=TRUE) + 
    geom_point(pch=3) + 
    facet_wrap( Type.of.feeding.interaction ~ ., ncol=1 ) +
    scale_x_log10() + scale_y_log10() + 
    theme(legend.position = "bottom", aspect.ratio = 0.5) +
    guides(color = guide_legend(nrow=1))
print(p)
graphics.off()

#linear regression
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Predator.lifestage <- as.factor(MyDF$Predator.lifestage)

mydf1 =  MyDF %>% 
        group_by(Type.of.feeding.interaction,Predator.lifestage) %>%
        do(glance(lm(log(Predator.mass) ~ log(Prey.mass),data = .)))
mydf2 =  MyDF %>% 
        group_by(Type.of.feeding.interaction,Predator.lifestage) %>%
        do(tidy(lm(log(Predator.mass) ~ log(Prey.mass),data = .)))
                  
x = seq(1:length(mydf2$estimate)) # nolint
even = subset(x, x %% 2 == 0)                 
odd = subset(x, x %% 2 == 1)

output = data.frame(
mydf1$Type.of.feeding.interaction,
mydf1$Predator.lifestage,
slope = mydf2$estimate[even],
intercept = mydf2$estimate[odd],
R.squared = mydf1$adj.r.squared,
F.value = mydf1$statistic,
p.value = mydf1$p.value
)

write.csv(output, "../results/PP_Regress_Results.csv", row.names = F)