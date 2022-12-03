rm(list = ls())
require(ggplot2)


tempAICc <- read.csv("../results/tempAICc.csv")
tempBIC <- read.csv("../results/tempBIC.csv")
tempR2 <- read.csv("../results/tempR2.csv")

tempAICc$ID <- as.factor(tempAICc$ID)
tempBIC$ID <- as.factor(tempBIC$ID)
tempR2$ID <- as.factor(tempR2$ID)



## AICc analysis ##


# Create Akaike weight and delta of AICc
tempAICc$Akaike_weight <- rep(NA)
delta <- vector(length = 4)
akaike_w <- vector(length = 4)

# compre AICc values of 4 models:

for (i in 1:nlevels(tempAICc$ID)) {

  aicc <- subset(tempAICc, ID == i)

  # rank AICc in order of increasing
  rank_aicc <- sort(aicc$AICc)

  # if the difference between smallest AICc and others is greater than 2, model has smallest AICc is best model
  if (isTRUE(rank_aicc[2] - rank_aicc[1] > 2)) {
    tempAICc$score[which(tempAICc$ID == i & tempAICc$AICc == rank_aicc[1])] <- 1
  }
  else {
  # if the difference is less than 2, these models are all recorded as the best
    for (n in 1:4) {
      if(isTRUE(rank_aicc[n] - rank_aicc[1] < 2))
        tempAICc$score[which(tempAICc$ID == i & tempAICc$AICc == rank_aicc[n])] <- 1
    }
  }
  # Calculate delta and akaike weight then store them.
  for (m in 1:4) {
    delta[m] <- rank_aicc[m] - rank_aicc[1]
    akaike_w[m] <- exp(-0.5 * delta[m]) / (exp(-0.5 * delta[1]) + exp(-0.5 * delta[2]) + exp(-0.5 * delta[3]) + exp(-0.5 * delta[4]))
    tempAICc$Akaike_weight[which(tempAICc$ID == i & tempAICc$AICc == rank_aicc[m])] <- akaike_w[m]
  }
  
}


# Count all of models when they fitted the best in AICc rules
bestA <- subset(tempAICc, score == 1)

QuadraticA <- subset(bestA, model == "Quadratic")
Num_QudraticA <- length(unique(QuadraticA$ID))

CubicA <- subset(bestA, model == "Cubic")
Num_CubicA <- length(unique(CubicA$ID))

LogisticA <- subset(bestA, model == "Logistic")
Num_LogisticA <- length(unique(LogisticA$ID))

GompertzA <- subset(bestA, model == "Gompertz")
Num_GompertzA <- length(unique(GompertzA$ID))

# Calculate mean of Akaike weight of 4 models and print them
print("_________________________________________")
print("Mean of Akaike weight value:")
Quadratic_AKaike_weight_summary <- summary(QuadraticA$Akaike_weight)
Cubic_AKaike_weight_summary <- summary(CubicA$Akaike_weight)
Logistic_AKaike_weight_summary <- summary(LogisticA$Akaike_weight)
Gompertz_AKaike_weight_summary <- summary(GompertzA$Akaike_weight)

print(paste0("Quadratic model: ", Quadratic_AKaike_weight_summary[4]))
print(paste0("Cubic model: ", Cubic_AKaike_weight_summary[4]))
print(paste0("Logistic model: ", Logistic_AKaike_weight_summary[4]))
print(paste0("Gompertz model: ", Gompertz_AKaike_weight_summary[4]))


# print the result
print("_________________________________________")
print(paste0("By AICc, the number of quadratic model fitted best is: " , Num_QudraticA, " ; ",
"Cubic model: ", Num_CubicA, " ; ",
"Logistic model: ", Num_LogisticA, " ; ",
"Gompertz model: ", Num_GompertzA))



# plot the best model counts results by AICc
pdf("../results/AICc_plot.pdf")
AICc_plot <- ggplot(tempAICc, aes(x = score, fill = model)) +
    ggtitle("Best model counts(AICc)") +
    geom_bar(position = "dodge") +
    labs(x = NULL, y = "Count") +
    theme_bw()
print(AICc_plot)
dev.off()

# plot Akaike weight results
pdf("../results/Akaike_weight.pdf")
AKW_P <- ggplot(tempAICc, aes(x = model, y = Akaike_weight, fill = model)) +
    geom_boxplot() +
    labs(x = NULL, y = "Akaike weight") +
    theme_bw()
print(AKW_P)
dev.off()


## BIC analysis ##

# compre BIC values of 4 models:

for (i in 1:nlevels(tempBIC$ID)) {

  bic <- subset(tempBIC, ID == i)

  # rank bic in order of increasing
  rank_bic <- sort(bic$BIC)

  # if the difference between smallest and others is greater than 2, model with smallest BIC is best model.
  if (isTRUE(rank_bic[2] - rank_bic[1] > 2)) {
    tempBIC$score[which(tempBIC$ID == i & tempBIC$BIC == rank_bic[1])] <- 1
  }
  else { # otherwise, these models will all be the best
    for (n in 1:4) {
      if(isTRUE(rank_bic[n] - rank_bic[1] < 2))
        tempBIC$score[which(tempBIC$ID == i & tempBIC$BIC == rank_bic[n])] <- 1
    }
     
  }
}

# Count all of models when they fitted the best in BIC rules
bestB <- subset(tempBIC, score == 1)

QuadraticB <- subset(bestB, model == "Quadratic")
Num_QudraticB <- length(unique(QuadraticB$ID))

CubicB <- subset(bestB, model == "Cubic")
Num_CubicB <- length(unique(CubicB$ID))

LogisticB <- subset(bestB, model == "Logistic")
Num_LogisticB <- length(unique(LogisticB$ID))

GompertzB <- subset(bestB, model == "Gompertz")
Num_GompertzB <- length(unique(GompertzB$ID))



# print the result
print(paste0("By BIC, the number of quadratic model fitted best is: " , Num_QudraticB, " ; ",
"Cubic model: ", Num_CubicB, " ; ",
"Logistic model: ", Num_LogisticB, " ; ",
"Gompertz model: ", Num_GompertzB))



# plot the best model counts results by BIC
pdf("../results/BIC_plot.pdf")
BIC_plot <- ggplot(tempBIC, aes(x = score, fill = model)) +
    ggtitle("Best model counts(BIC)") +
    geom_bar(position = "dodge") +
    labs(x = NULL, y = "Count") +
    theme_bw()
print(BIC_plot)
dev.off()






## R^2 analysis

# compre R^2 values of 4 models:

for (i in 1:nlevels(tempR2$ID)) {
     tempR2$score[which(tempR2$ID == i & tempR2$R2 > 0.9)] <- 1
  }



# Count all of models when they fitted the best in R^2 rules
bestR <- subset(tempR2, score == 1)

QuadraticR <- subset(bestR, model == "Quadratic")
Num_QudraticR <- length(unique(QuadraticR$ID))

CubicR <- subset(bestR, model == "Cubic")
Num_CubicR <- length(unique(CubicR$ID))

LogisticR <- subset(bestR, model == "Logistic")
Num_LogisticR <- length(unique(LogisticR$ID))

GompertzR <- subset(bestR, model == "Gompertz")
Num_GompertzR <- length(unique(GompertzR$ID))



# print the results
print(paste0("R squared of quadratic model over 0.9 is: " , Num_QudraticR, " ; ",
"cubic model: ", Num_CubicR, " ; ",
"Logistic model: ", Num_LogisticR, " ; ",
"Gompertz model: ", Num_GompertzR))
print("_________________________________________")



# R squared plotting
pdf("../results/R2_plot.pdf")
R2_plot <- ggplot(tempR2, aes(x = model, y = R2, fill = model)) +
    geom_boxplot() +
    labs(x = NULL, y = "R squared") +
    scale_y_continuous(limits = c(0.95, 1)) +
    theme_bw() +
    theme(legend.position = "none", text = element_text(size = 15))
print(R2_plot)
dev.off()
