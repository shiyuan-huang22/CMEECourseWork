# CMEE 2022 HPC exercises R code pro forma
# For neutral model cluster run

rm(list = ls())
graphics.off()
source("sh422_HPC_2022_main.R")

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

my_rate <- 0.54

set.seed(iter)

if(1 <= iter && iter <= 25){
   mysize <- 500
}else if (26 <= iter && iter <= 50) {
   mysize <- 1000
}else if (51 <= iter && iter <= 75) {
   mysize <- 2500
}else if (76 <= iter && iter <= 100) {
   mysize <- 5000
}

filename <- paste0("neutral_simulation_result", iter, ".rda")
neutral_cluster_run(speciation_rate = my_rate, size = mysize, wall_time = (11.5*60), interval_rich = 1, interval_oct = mysize/10, burn_in_generations = 8*mysize, output_file_name = filename)