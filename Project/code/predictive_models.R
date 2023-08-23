# This script is for building fouth coner model to make a relative abundance prediction for specific sites
# And also assess the prediction with different combinations of traits and environments by RMSE and R-squared.

rm(list = ls())
library(mvabund)
library(vegan)

abun_data <- read.csv("../data/trydata/rel_abun.csv")

# Read trait data
trait_data <- read.csv("../data/trydata/unscaled_imputed_result_by_missForest_with_phylogenetic_tree.csv", header = TRUE)
trait_data <- trait_data[trait_data$X != "Arenaria_leptoclados", ]
row.names(trait_data) <- trait_data$X
trait_data <- trait_data[, 2:6]

# Make plot, month and year as factors then put them in a dataframe
plot <- as.factor(abun_data[, 6])
month <- as.factor(abun_data[, 7])
year <- as.factor(abun_data[, 3])
block <- as.factor(abun_data[, 5])
env <- data.frame(year, plot, month, block)

# We only need the abundance data here
abun <- abun_data[, 9:86]

# Remove species whos' abundances are all 0
all_zeros <- apply(abun, 2, function(x) all(x == 0))
zero_cols <- which(all_zeros)
updated_abun <- abun[, -zero_cols]
updated_trait <- trait_data[-zero_cols, ]


#1. RMSE function
RMSE <- function(y_actual, y_predict) {
  rmse <- sqrt(mean(y_actual - y_predict)^2)

  return(rmse)
}

#2. R SQUARED error metric -- Coefficient of Determination function
RSQUARE <- function(y_actual, y_predict) {

  r2 <- cor(as.numeric(y_actual), as.numeric(y_predict)) ^ 2

  return(r2)
}


# Build a simulation of the fourth corner model and calculate the RMSE and R-squared
traitglm_simulation <- function(abun, trait_data, env, training_rate, simulation_times, group_num){ # nolint


  results <- data.frame(nrow = simulation_times, ncol = 2)

  for (i in 1: simulation_times){
  
  set.seed(i * group_num + 1234)

  training <- sample(nrow(abun), nrow(abun) * training_rate)

  model1 <- traitglm(L = round(abun[training, ]), R = env[training, ], Q = trait_data)

  model2 <- predict.traitglm(model1, newR = env[-training, ])


  real_abun <- as.matrix(abun[-training, ])

 
  rmse_result <- RMSE(real_abun, model2) # nolint
  r2_result <- RSQUARE(real_abun, model2) # nolint
  
  results[i, 1] <- rmse_result
  results[i, 2] <- r2_result


  }

  colnames(results) <- c("RMSE", "R2")
  return(results)

}

# Due to the usage is insufficient on this laptop, the simulation always crashed,
# so we divided the 1000 times simulations into 4 groups then ran them individually.
# Here is a function to do this process
mean_calculator <- function(abun, trait, env, training_rate, simulation_times) {
  
  simulation_1 <- traitglm_simulation(abun, trait, env, training_rate, simulation_times / 4, 1)
  simulation_2 <- traitglm_simulation(abun, trait, env, training_rate, simulation_times / 4, 2)
  simulation_3 <- traitglm_simulation(abun, trait, env, training_rate, simulation_times / 4, 3)
  simulation_4 <- traitglm_simulation(abun, trait, env, training_rate, simulation_times / 4, 4)
  
  r2 <- c(simulation_1[, 2], simulation_2[, 2], simulation_3[, 2], simulation_4[, 2])
  rmse <- c(simulation_1[, 1], simulation_2[, 1], simulation_3[, 1], simulation_4[, 1])

  r2_result <- t.test(r2, conf.level = 0.95)
  r2_ci_lower <- r2_result$conf.int[1]
  r2_ci_upper <- r2_result$conf.int[2]
  
  rmse_result <- t.test(rmse, conf.level = 0.95)
  rmse_ci_lower <- rmse_result$conf.int[1]
  rmse_ci_upper <- rmse_result$conf.int[2]
  
  r2_mean <- mean(r2)
  rmse_mean <- mean(rmse)
  
  result <- data.frame(r2_ci_lower = r2_ci_lower, r2_ci_upper = r2_ci_upper, r2_mean = r2_mean, 
                       rmse_ci_lower = rmse_ci_lower, rmse_ci_upper = rmse_ci_upper, rmse_mean = rmse_mean)
  
  return(result)
}


## And to reduce runtime, I ran all my code on Posit Cloud.
## Here a example showed how to run the simulation.
## For all environment variable, fit traitglm

year_month_l_gr_t_sd <- mean_calculator(updated_abun, updated_trait[, c(2, 3, 4, 5)], env[, c(1,3)], 0.8, 1000)
year_month_l_gr_t_sd



### calculate mean of real relative abundance
real_mean <- mean(colMeans(abun))
real_mean