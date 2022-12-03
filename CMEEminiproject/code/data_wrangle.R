rm(list = ls())

data <- read.csv("../data/LogisticGrowthData.csv")
print(paste("Loaded", ncol(data), "columns", sep = " "))

# remove negative time  - it will improve model fitting
data  <- subset(data, Time > 0)
# remove negative PopBio - it doesn't make sense to have negative PopBio
data <- subset(data, PopBio > 0)

# Create ID which containing species, temperature, medium, citation
data$ID <- paste(data$Species, data$Temp, data$Medium, data$Citation, sep = " ")
data$ID <- as.factor(data$ID)

# Create log values of PopBio
data$LogPopBio <- log(data$PopBio)


# check how many IDs did we have
nlevels(data$ID)

# replace created ID with numbers
levels(data$ID) <- 1:285


write.csv(data, "../data/ModiData.csv")
print("Data filtration has been completed")
