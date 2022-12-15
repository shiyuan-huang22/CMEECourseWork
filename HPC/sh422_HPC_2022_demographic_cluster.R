# CMEE 2022 HPC exercises R code pro forma
# For stochastic demographic model cluster run

rm(list = ls())
graphics.off()
source("sh422_HPC_2022_main.R")

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))


set.seed(iter)
ini_con <- c()
# create the projection matrix
projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
# create clutch distribution
clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)


if(1 <= iter && iter <= 250){
   ini_con <- state_initialise_adult(4, 100)
}else if (251 <= iter && iter <= 500) {
   ini_con <- state_initialise_adult(4, 10)
}else if (501 <= iter && iter <= 750) {
   ini_con <- state_initialise_spread(4, 100)
}else if (751 <= iter && iter <= 1000) {
   ini_con <- state_initialise_spread(4, 10)
}

filename <- paste0("stochastic_simulation_result", iter, ".rda")
results <- stochastic_simulation(initial_state = ini_con, projection_matrix = projection_matrix, clutch_distribution = clutch_distribution, simulation_length = 120)
save(results, file = filename)