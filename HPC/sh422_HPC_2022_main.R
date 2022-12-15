# CMEE 2022 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "SHIYUAN HUANG"
preferred_name <- "SHIYUAN"
email <- "shiyuan.huang22@imperial.ac.uk"
username <- "sh422"

# Please remember *not* to clear the workspace here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community){
  spe_ric <- length(unique(community))
  return(spe_ric)
}

# Question 2
init_community_max <- function(size){
  ini_com_max <- seq(size)
  return(ini_com_max)
}

# Question 3
init_community_min <- function(size){
  ini_com_min <- rep(1, size)
  return(ini_com_min)
}

# Question 4
choose_two <- function(max_value){
  vec <- c(1:max_value)
  two_nums <- sample(vec, 2, replace = FALSE)
  return(two_nums)
}

# Question 5
neutral_step <- function(community){
  index <- choose_two(length(community))
  community[index[1]] <- community[index[2]]
  return(community)
}

# Question 6
neutral_generation <- function(community){
  if (length(community) %% 2 == 0){
    gen_length <- length(community) / 2
  }else{
    gen_length <- length(community) / 2 + sample(c(0.5, -0.5), 1) # 0.5 round up, -0.5 round down
  }
  for (i in 1:gen_length) {
    new_community <- neutral_step(community)
  }
  return(new_community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  time_series <- c(species_richness(community))
  for(i in 1:duration){
    community <- neutral_generation(community)
    richness <- species_richness(community)
    time_series <- c(time_series, richness)
  }
  return(time_series)
}

# Question 8
question_8 <- function() {
  community <- init_community_max(100)
  richness <- neutral_time_series(community, 200)
  png(filename="question_8.png", width = 600, height = 400)
  # plot your graph here
  par(mfrow = c(1,1))
  plot(1:length(richness),richness, type = "l", xlab = "Time of generations", ylab = "species richness", main = "Neutral model without speciation")
  Sys.sleep(0.1)
  dev.off()
  return("This system will always converge to state where species richness equals to 1. Because the species richness can not increase since there is no new species. But it's possible that species richness will decrease. Extinct specise can not reproduce. In this case, community will exist one species eventually.")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  index <- choose_two(length(community))[1]
  if(speciation_rate >= runif(1, min = 0, max = 1)){
    community <- neutral_step(community)
  }
  else {
    community[index] <- max(community) + 1  # This makes the new species different from old species.
  }
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  gen_length <- length(community)
  if(length(community) %% 2 == 0){
    gen_length <- gen_length / 2
  }
  else {
    gen_length <- length(community) / 2 + sample(c(0.5, -0.5), 1)
  }
  for(i in seq(gen_length)){
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  time_series <- c(species_richness(community))
  for(i in 1:duration) {
    community <- neutral_generation_speciation(community, speciation_rate)
    richness <- species_richness(community)
    time_series <- c(time_series, richness)
  }
  return(time_series)
}

# Question 12
question_12 <- function() { 
  time_series_min <- neutral_time_series_speciation(community = init_community_min(100), duration = 200, speciation_rate = 0.1)
  time_series_max <- neutral_time_series_speciation(community = init_community_max(100), duration = 200, speciation_rate = 0.1)
  
  png(filename="question_12.png", width = 600, height = 400)
  # plot your graph here
  par(mfrow = c(1,1))
  plot(1:length(time_series_min), time_series_min, type = "l", col = 2, xlab = "Time of generations", ylab = "species richness", main = "Neutral model with speciation")
  lines(1:length(time_series_max), time_series_max, col = 3)
  legend("topright", c("Minimum richness", "Maximum richness"), fill = 2: 3, col = 2: 3, lwd = 2, bty = "n")
  Sys.sleep(0.1)
  dev.off()
  
  return("By neutral model simulation,regardless of the initialized richness status, different communities with same speciation rate will approach the same dynamic equilibrium. Because chances of speciation and extinction equal to each other, which lead to dynamic equilibrium of community.")
}

# Question 13
species_abundance <- function(community)  {
  spe_abu <- as.numeric(sort(table(community), decreasing = TRUE))
  return(spe_abu)
}

# Question 14
octaves <- function(abundance_vector) {
  bin <- floor(log2(abundance_vector)) + 1 # add 1 since 0 will be ignored
  octave <- tabulate(bin)
  return(octave)
}

# Question 15
sum_vect <- function(x, y) {
  if (length(x) >= length(y)) {
    short <- y
    long <- x
  }
  else {
    short <- x
    long <- y
  }
  length_diff <- length(long) - length(short)
  short <- append(short, rep(0, length_diff))
  sum <- short + long
  return(sum)
}

# Question 16 
question_16 <- function() {
  for (i in 1:200){
    min <- neutral_generation_speciation(init_community_min(100),speciation_rate = 0.1)
    max <- neutral_generation_speciation(init_community_max(100),speciation_rate = 0.1)
  }

  octave_min <- octaves(species_abundance(min)) #get octaves after first 200 generations
  octave_max <- octaves(species_abundance(max))

  for (i in 1:2000){
    min <- neutral_generation_speciation(min, speciation_rate = 0.1)
    max <- neutral_generation_speciation(max, speciation_rate = 0.1)
    if (i %% 20 == 0){
      octave_min <- sum_vect(octaves(species_abundance(min)), octave_min)
      octave_max <- sum_vect(octaves(species_abundance(max)), octave_max)
    }
  }

  num_loop <- 2000/20 + 1
  min_mean <- octave_min / num_loop #create mean of octaves
  max_mean <- octave_max / num_loop
  
  # create bin name (x axis)
  min_x <- list()
  min_index <- seq(length(min_mean))
  for (i in min_index) {
    min_x <- append(min_x, paste0("(", 2^(i - 1), "-", (2^i) - 1, ")"))
  }
  max_x <- list()
  max_index <- seq(length(max_mean))
  for (i in max_index) {
    max_x <- append(max_x, paste0("(", 2^(i - 1), "-", (2^i) - 1, ")"))
  }

  png(filename="question_16_min.png", width = 600, height = 400)
  # plot your graph here
  barplot(min_mean, names.arg = min_x, xlab = "Number of individuals per species",
  ylab = "Mean of species", main = "Octaves of species abundance distribution(min)")
  Sys.sleep(0.1)
  dev.off()
  
  png(filename="question_16_max.png", width = 600, height = 400)
  # plot your graph here
  barplot(max_mean, names.arg = max_x, xlab = "Number of individuals per species",
  ylab = "Mean of species", main = "Octaves of species abundance distribution(max)")
  Sys.sleep(0.1)
  dev.off()
  
  return("The initial condition of the system does not matter. Regardless of the initial state of richness, both communities with same speciation rate will reach the same dynamic equilibrium. Because speciation rate and extinction rate are same, both communities has the same patterns")
}

# Question 17
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
    start_t <- proc.time()[3] #start timer
    community <- init_community_min(size)
    time_series <- c()
    abundance_list <- list()
    gen_count <- 0

    while (proc.time()[3] - start_t <= wall_time*60) {
      community <- neutral_generation_speciation(community, speciation_rate)
      gen_count <- gen_count + 1

      if(gen_count <= burn_in_generations && gen_count %% interval_rich == 0) {
        richness <- species_richness(community)
        time_series <- c(time_series, richness)
      }

      if(gen_count %% interval_oct == 0) {
        abundance <- list(octaves(species_abundance(community)))
        abundance_list <- append(abundance_list, abundance)
      }
    
    }
    total_time <- (proc.time()[3] - start_t) / 60 # Transfer to minutes
    save(time_series, abundance_list, community, total_time, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on
# the cluster

# Question 20 
process_neutral_cluster_results <- function() {
  combined_results <- list() #create your list output here to return
  # save results to an .rda file
  size500 <- rep(0)
  size1000 <- rep(0)
  size2500 <- rep(0)
  size5000 <- rep(0)

  # rda file 32-37, 82 did not exist since job killed: walltime exceeded limit, please check the efile
  index <- c(1:31, 38:81, 83:100)
  for (i in index) {
    n <- 0

    load(file = paste0("neutral_simulation_result", i, ".rda"))
    # delete data before burn in generations
    abundance_list <- abundance_list[(burn_in_generations / interval_oct) + 1 : length(abundance_list)]
    oct_sum <- rep(0)
    index_list <- seq(length(abundance_list))
    for (j in index_list) {
      oct_sum <- sum_vect(oct_sum, abundance_list[[j]])
      n <- n + 1
    }
    oct_mean <- oct_sum / n

    if (size == 500) {
      size500 <- sum_vect(size500, oct_mean)
    }else if (size == 1000) {
      size1000 <- sum_vect(size1000, oct_mean)
    }else if (size == 2500) {
      size2500 <- sum_vect(size2500, oct_mean)
    }else if (size == 5000) {
      size5000 <- sum_vect(size5000, oct_mean)
    }
  }
  mean500 <- size500 / 25
  mean1000 <- size1000 / 19 # 32-37 did not exist, so 25 - 6
  mean2500 <- size2500 / 25
  mean5000 <- size5000 / 24 # 82 did not exist, so 25 - 1
  combined_results <- list(mean500, mean1000, mean2500, mean5000)
  save(combined_results, file = "neutral_cluster_results.rda")
}
  

plot_neutral_cluster_results <- function(){

  # load combined_results from your rda file
  load(file = "neutral_cluster_results.rda")
  plot500 <- combined_results[[1]]
  plot1000 <- combined_results[[2]]
  plot2500 <- combined_results[[3]]
  plot5000 <- combined_results[[4]]


  # create x axis
  x_500 <- list()
  for (j in 1:length(plot500)) {
    x_500 <- append(x_500, paste0("(", 2^(j - 1), "-", (2^j) - 1, ")"))
  }
  x_1000 <- list()
  for (i in 1:length(plot1000)) {
    x_1000 <- append(x_1000, paste0("(", 2^(i - 1), "-", (2^i) - 1, ")"))
  }
  x_2500 <- list()
  for (n in 1:length(plot2500)) {
    x_2500 <- append(x_2500, paste0("(", 2^(n - 1), "-", (2^n) - 1, ")"))
  }
  x_5000 <- list()
  for (m in 1:length(plot5000)) {
    x_5000 <- append(x_5000, paste0("(", 2^(m - 1), "-", (2^m) - 1, ")"))
  }
  
  png(filename="plot_neutral_cluster_results.png", width = 600, height = 400)
  par(mfrow = c(2, 2))
  # plot your graph here
  barplot(plot500, names.arg = x_500, xlab = "Number of individuals per species",
          ylab = "Mean of abundance octave", col = "red", main = "Community size 500")
  barplot(plot1000, names.arg = x_1000, xlab = "Number of individuals per species",
          ylab = "Mean of abundance octave", col = "yellow", main = "Community size 1000")
  barplot(plot2500, names.arg = x_2500, xlab = "Number of individuals per species",
          ylab = "Mean of abundance octave", col = "blue", main = "Community size 2500")
  barplot(plot5000, names.arg = x_5000, xlab = "Number of individuals per species",
          ylab = "Mean of abundance octave", col = "green", main = "Community size 5000")
  Sys.sleep(0.1)
  dev.off()
  
  return(combined_results)
}


# Question 21
state_initialise_adult <- function(num_stages,initial_size){
  state <- rep(0, num_stages - 1)
  state <- append(state, initial_size)
  return(state)
}

# Question 22
state_initialise_spread <- function(num_stages,initial_size){
  d <- initial_size / num_stages
  if(initial_size %% num_stages == 0) {
    state <- rep(d, num_stages)
  }
  else {
    state <- rep(round(d), num_stages - 1)
    state <- append(state, initial_size - (num_stages - 1) * round(d))
  }
  return(state)
}

# Question 23
deterministic_step <- function(state,projection_matrix){
  new_state <- projection_matrix %*% state
  return(new_state)
}

# Question 24
deterministic_simulation <- function(initial_state,projection_matrix,simulation_length){

  population_size <- vector()
  population_size[1] <- sum(initial_state)
  state <- deterministic_step(initial_state, projection_matrix)

  for (i in 1:simulation_length) {
    state <- deterministic_step(state, projection_matrix)
    population_size[i+1] <- sum(state)
  }
  return(population_size)
}

# Question 25
question_25 <- function(){
  # two initial condition
  adults <- state_initialise_adult(4, 100)
  spread <- state_initialise_spread(4, 100)

  # create the projection matrix
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)

  adults_sim <- deterministic_simulation(adults, projection_matrix, 24)
  spread_sim <- deterministic_simulation(spread, projection_matrix, 24)

  png(filename = "question_25.png", width = 600, height = 400)
  # plot your graph here
  plot(x = seq(25), y = adults_sim, col = 2, type = "l", xlab = "time", ylab = "population size", main = "deterministic simulation")
  lines(spread_sim, col = 3, type = "l")
  legend("topright", legend = c("100 adults", "100 spread"), fill = 2: 3, title = "type", col = 2: 3)

  Sys.sleep(0.1)
  dev.off()
  
  return("The initial distribution has a stronger affect on the initial population growth and a smaller effect on the eventual population growth. For example, for the two initial conditions in this question, when 100 adults have a good rate of fertility, there are many births in the next generation so we get a population of 300 in the second simulation stage, but the population declines due to poor stay rates until the population grows steadily when it is evenly distributed over the four stages. In contrast, the population of 100 with the initial condition of an even distribution grows steadily from the start.")
}

# Question 26
trinomial <- function(pool,probs) {
  # special case, return the vector representing the situation where all individuals are assigned to event 1
  if (isTRUE(probs[1] == 1)) {
    result <- c(pool, 0, 0)
  }
  else {
    # A: staying in the current life stage
    A <- rbinom(1, pool, probs[1])
    BC <- pool - A
    # B: maturation
    prob_event_2 <- probs[2] / (1 - probs[1])
    B <- rbinom(1, BC, prob_event_2)
    # C: death
    C <- BC - B
    result <- (c(A, B, C))
  }
  return(result)
}

# Question 27
survival_maturation <- function(state,projection_matrix) {
  
  e <- length(state)
  new_state <- c()
  transition <- rep(0, 3)

  
  for (i in seq(e - 1)) {
    vec <- c(projection_matrix[i, i], projection_matrix[i + 1, i], 0)
    new_additions_to_stage_i <- trinomial(state[i], vec)
    remain <- new_additions_to_stage_i[1]
    new_state[i] <- remain + transition[i]
    transition[i+1] <- new_additions_to_stage_i[2]
    }

  new_state[e] <- transition[e] + trinomial(state[e], c(projection_matrix[e, e], 0))[1]
  


  return(new_state)

}

# Question 28
random_draw <- function(probability_distribution) {
  output <- 0
  rand_num <- runif(1)
  interval <- cumsum(probability_distribution)
  for (i in seq(length(probability_distribution) - 1))
    if(rand_num <= interval[1]) {
      output <- 1
    }
    else if (rand_num > interval[i] && rand_num <= interval[i + 1]) {
      output <- i + 1
    }

  return(output)
}

# Question 29
stochastic_recruitment <- function(projection_matrix,clutch_distribution){

  size <- seq(length(clutch_distribution))
  exp <- sum(clutch_distribution * size)
  # find the top right element
  l <- length(projection_matrix[1, ])
  recruitment_rate <- projection_matrix[1, l]

  p <- recruitment_rate / exp
  return(p)
}

# Question 30
offspring_calc <- function(state,clutch_distribution,recruitment_probability){
  adults <- state[length(state)]
  clutch_num <- rbinom(1, adults, recruitment_probability)
  clutch_size <- c()
  for (i in seq(clutch_num)){
    if (i == 0) {
      clutch_size <- 0
    }
    else {
      clutch_size[i] <- random_draw(clutch_distribution)
    }
  }
  total_offspring <- sum(clutch_size)
  return(total_offspring)
}

# Question 31
stochastic_step <- function(state,projection_matrix,clutch_distribution,recruitment_probability){
  new_state <- survival_maturation(state, projection_matrix)
  offspring <- offspring_calc(state, clutch_distribution, recruitment_probability)
  new_state[1] <- new_state[1] + offspring
  return(new_state)
}

# Question 32
stochastic_simulation <- function(initial_state,projection_matrix,clutch_distribution,simulation_length){
  population_size <- vector()
  population_size[1] <- sum(initial_state)
  p <- stochastic_recruitment(projection_matrix, clutch_distribution)
  state <- stochastic_step(initial_state, projection_matrix, clutch_distribution, p)

  for (i in seq(simulation_length)) {
    population_size[i + 1] <- sum(state)
    if (sum(state) == 0) {
      population_size[i + 1: simulation_length + 1] <- 0
      break
    }
    else {
    state <- stochastic_step(state, projection_matrix, clutch_distribution, p)
    }
  }
  return(population_size)
}

# Question 33
question_33 <- function(){
  # two initial condition
  adults <- state_initialise_adult(4, 100)
  spread <- state_initialise_spread(4, 100)

  # create the projection matrix
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
  
  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)

  adults_sim <- stochastic_simulation(adults, projection_matrix, clutch_distribution, 24)
  spread_sim <- stochastic_simulation(spread, projection_matrix, clutch_distribution, 24)

  png(filename="question_33.png", width = 600, height = 400)

  # plot your graph here
  plot(x = seq(25), y = adults_sim, col = 2, type = "l", xlab = "time", ylab = "population size", main = "stochastic simulation")
  lines(spread_sim, col = 3, type = "l")
  legend("topright", legend = c("100 adults", "100 spread"), fill = 2: 3, title = "type", col = 2: 3)
  Sys.sleep(0.1)
  dev.off()
  
  return("The deterministic simulation has a smoother pattern than the stochastic simulation. The reason for this is that stochastic simulation adds uncertainty to the growth of the population, leading to the possibility that the population may suddenly decline at a time of steady growth. Deterministic simulation, however, does not have this problem.")
}

# Questions 34 and 35 involve writing code elsewhere to run your simulations on the cluster

# Question 36
question_36 <- function(){ 
  extinction_times <- vector()

  for(i in seq(1000)) {
 
    filename <- paste0("stochastic_simulation_result", i, ".rda")
    load(filename)
    
    l <- length(results)
    # if extinction happend, count 1 and record. Otherwise, count 0
    if (results[l] == 0) {
      extinction_times[i] <- 1
      print(i)
    }
    else {
      extinction_times[i] <- 0
    }
  time_of_1_250 <- sum(extinction_times[1:250])
  time_of_251_500 <- sum(extinction_times[251:500])
  time_of_501_750 <- sum(extinction_times[501:750])
  time_of_751_1000 <- sum(extinction_times[751:1000])
  
  proportion <- c(time_of_1_250, time_of_251_500, time_of_501_750, time_of_751_1000)
  proportion <- proportion / 250
  x <- c("adults,large", "adult,small", "spread,large", "spread,small")
  dev.off()

  png(filename = "question_36.png", width = 600, height = 400)
  # plot your graph here
  barplot(proportion, ylim = c(0:1), names.arg = x, xlab = "initial condition", ylab = "extinction times", main = "extinction times of 4 different initial condition")
  }
  Sys.sleep(0.1)
  dev.off()
  return("population spread out across the life stages with small population size was most likely to go extinct than all adults. Because spread population with small population size produces the fewest offspring at the beginning. When it encounters a few individuals who die it will easily lead to the death of the majority of the population, and because the population is so small it will be difficult to grow again.")
}

# Question 37
question_37 <- function(){

  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)


  # stochastic simulation in initial condition 3
  n <- 1
  mean_large <- vector()
  for(i in 501:750) {
 
    filename <- paste0("stochastic_simulation_result", i, ".rda")
    load(filename)
    pop_size <- sum(results)
    mean_large[n] <- pop_size / 121
    n <- n + 1
  }

  # deterministic simulation in initial condition 3
  d_3 <- deterministic_simulation(state_initialise_spread(4, 100), projection_matrix, 120)
  

  # stochastic simulation in initial condition 4
  m <- 1
  mean_small <- vector()
  for(i in 751:1000) {

    filename <- paste0("stochastic_simulation_result", i, ".rda")
    load(filename)
    pop_size <- sum(results)
    mean_small[m] <- pop_size / 121
    m <- m + 1
  }


  # deterministic simulation in initial condition 4
  d_4 <- deterministic_simulation(state_initialise_spread(4, 10), projection_matrix, 120)


  dev.off()
  png(filename="question_37_small.png", width = 600, height = 400)
  # plot your graph for the small initial population size here
  plot(x = seq(250), y = mean_large, col = 2, type = "l", xlab = "time", ylab = "population size", main = "initial condition 3")
  lines(d_3, col = 3, type = "l")
  legend("topright", legend = c("stochastic", "deterministic"), fill = 2: 3, title = "type", col = 2: 3)
  Sys.sleep(0.1)
  dev.off()
  
  png(filename="question_37_large.png", width = 600, height = 400)
  # plot your graph for the large initial population size here
  plot(x = seq(250), y = mean_small, col = 2, type = "l", xlab = "time", ylab = "population size", main = "initial condition 4")
  lines(d_4, col = 3, type = "l")
  legend("topright", legend = c("stochastic", "deterministic"), fill = 2: 3, title = "type", col = 2: 3)
  Sys.sleep(0.1)
  dev.off()
  
  return("In fact I don't think it is appropriate to use a deterministic model to approximate the average behaviour of that stochastic system at any time for a spread population of any size")
}



# Challenge questions - these are optional, substantially harder, and a maximum
# of 14% is available for doing them. 

# Challenge question A
Challenge_A <- function() {
   
  max <- matrix(nrow = 101, ncol = 100)
  min <- matrix(nrow = 101, ncol = 100)
  for (i in seq(100)) {
    max[,i] <- neutral_time_series_speciation(init_community_max(100), 0.1, 100)
    min[,i] <- neutral_time_series_speciation(init_community_min(100), 0.1, 100)
  }

  mean_min <- rowMeans(min)
  mean_max <- rowMeans(max)

  # calculate 97.2% confidence interval
  alpha <- 0.028
  df <- 100 - 1
  lowerbound_min <- list()
  upperbound_min <- list()
  lowerbound_max <- list()
  upperbound_max <- list()
  
  for (i in seq(101)) {
    sd_min <- sd(min[i, ])
    sd_max <- sd(max[i, ])
    t_min <- qt(p = alpha / 2, df = df, lower.tail = F)
    t_max <- qt(p = alpha / 2, df = df, lower.tail = F)

    lowerbound_min[i] <- mean_min[i] - t_min * sd_min
    upperbound_min[i] <- mean_min[i] + t_min * sd_min
    lowerbound_max[i] <- mean_max[i] - t_max * sd_max
    upperbound_max[i] <- mean_max[i] + t_max * sd_max
  }
  
  for (i in seq(101)) {
    if(mean_max[i] <= mean_min[i]) {
      print(paste0("The number of generations needed for the system to reach dynamic equilibrium is: ", i))
      break
    }
  }
  
  png(filename = "Challenge_A_min.png", width = 600, height = 400)
  # plot your graph here
  plot(x = seq(101), y = mean_min, col = "blue", type = "l", 
   ylab = "mean of species richness", xlab = "generations",
   main = "mean species richness in minimum initial species richness")
  polygon(c(1:101, 101:1), c(upperbound_min, rev(lowerbound_min)), col = "yellow", density = 80)

  Sys.sleep(0.1)
  dev.off()
  
  png(filename = "Challenge_A_max.png", width = 600, height = 400)
  # plot your graph here
  plot(x = seq(101), y = mean_max, col = "red", type = "l", 
   ylab = "mean of species richness", xlab = "generations",
   main = "mean species richness in maximum initial species richness")
  polygon(c(1:101, 101:1), c(upperbound_max, rev(lowerbound_max)), col = "pink", density = 80)

  Sys.sleep(0.1)
  dev.off()

}

# Challenge question B

# create a function to generate community with given size and richness
create_random_init_comm <- function(size, richness) {
  comm <- sample(x = seq(richness), size = size, replace = TRUE)
  return(comm)
}

Challenge_B <- function() {

  richness_vector <- c(4, 5, 8, 9, 11, 12)

  # plot your graph here
  png(filename = "Challenge_B.png", width = 600, height = 400)
  plot(x = 0, y = 0, xlim = c(1, 10), ylim = c(184, 190), type = "n", xlab = "repeat times", ylab = "averaged time series", main = "neutral simulation with different initial species richness")
  
  for (i in richness_vector) {
    init_comm <- create_random_init_comm(200, i)
    time_series <- matrix(nrow = 10, ncol = 201)
    for (j in seq(10)) {
      time_series[j, ] <- neutral_time_series_speciation(init_comm, 0.1, 200)
    }
    mean_time_series <- rowMeans(time_series)
    lines(mean_time_series, col = i)
    }
  legend("bottomright", legend = richness_vector, fill = richness_vector, title = "initial richness species")

  Sys.sleep(0.1)
  dev.off()

}

# Challenge question C
mean_calculator_for_C <- function(range) {
  sum <- rep(0)
  count <- 0
  for (i in range) {
    filename <- paste0("neutral_simulation_result", i, ".rda")
    load(filename)
    sum <- sum_vect(sum, time_series)
    count = count + 1
  }
  mean <- sum / count
  return(mean)
}

Challenge_C <- function() {
  mean_500 <- mean_calculator_for_C(1:25)
  l1000 <- c(26:31, 38:50)
  mean_1000 <- mean_calculator_for_C(l1000)
  mean_2500 <- mean_calculator_for_C(51:75)
  l5000 <- c(76:81, 83:100)
  mean_5000 <- mean_calculator_for_C(l5000)
  
  png(filename="Challenge_C.png", width = 600, height = 400)
  par(mfrow = c(2, 2))
  # plot your graph here
  plot(mean_500, type = "l", col = "red", xlab = "time", ylab = "mean species richness", main = "size 500")
  plot(mean_1000, type = "l", col = "blue", xlab = "time", ylab = "mean species richness", main = "size 1000")
  plot(mean_2500, type = "l", col = "yellow", xlab = "time", ylab = "mean species richness", main = "size 2500")
  plot(mean_5000, type = "l", col = "green", xlab = "time", ylab = "mean species richness", main = "size 5000")

  Sys.sleep(0.1)
  dev.off()

}

# Challenge question D
simulation_coalesence <- function(J, v) {
  lineages <- rep(1, J)
  abundance <- vector()
  N <- J
  theta <- v * (J - 1) / (1 - v)

  while (N > 1) {
    mysample <- choose_two(length(lineages))
    i <- mysample[1]
    j <- mysample[2]

    random <- runif(1)
    if (random < theta / (theta + N - 1)){
      abundance <- append(abundance, lineages[j])
    }
    else {
      lineages[i] <- lineages[i] + lineages[j]
    }
    lineages <- lineages[-j]
    N <- N - 1
  }

  abundance <- c(abundance, lineages)
  return(abundance)
}

Challenge_D <- function() {
  v <- 0.008
  size_500 <- rep(0)
  size_1000 <- rep(0)
  size_2500 <- rep(0)
  size_5000 <- rep(0)

  load("neutral_cluster_results.rda")
  plot500 <- combined_results[[1]]
  plot1000 <- combined_results[[2]]
  plot2500 <- combined_results[[3]]
  plot5000 <- combined_results[[4]]

  
  for (i in seq(25)) {
    size_500 <- sum_vect(size_500, octaves(simulation_coalesence(500, v)))
    size_1000 <- sum_vect(size_1000, octaves(simulation_coalesence(1000, v)))
    size_2500 <- sum_vect(size_2500, octaves(simulation_coalesence(2500, v)))
    size_5000 <- sum_vect(size_5000, octaves(simulation_coalesence(5000, v)))
  }
  mean_500 <- size_500 / 25
  mean_1000 <- size_1000 / 25
  mean_2500 <- size_2500 / 25
  mean_5000 <- size_2500 / 25


  # create x axis
  x_500c <- list()
  for (j in 1:length(mean_500)) {
    x_500c <- append(x_500c, paste0("(", 2^(j - 1), "-", (2^j) - 1, ")"))
  }
  x_1000c <- list()
  for (i in 1:length(mean_1000)) {
    x_1000c <- append(x_1000c, paste0("(", 2^(i - 1), "-", (2^i) - 1, ")"))
  }
  x_2500c <- list()
  for (n in 1:length(mean_2500)) {
    x_2500c <- append(x_2500c, paste0("(", 2^(n - 1), "-", (2^n) - 1, ")"))
  }
  x_5000c <- list()
  for (m in 1:length(mean_5000)) {
    x_5000c <- append(x_5000c, paste0("(", 2^(m - 1), "-", (2^m) - 1, ")"))
  }

    x_500 <- list()
  for (j in 1:length(plot500)) {
    x_500 <- append(x_500, paste0("(", 2^(j - 1), "-", (2^j) - 1, ")"))
  }
  x_1000 <- list()
  for (i in 1:length(plot1000)) {
    x_1000 <- append(x_1000, paste0("(", 2^(i - 1), "-", (2^i) - 1, ")"))
  }
  x_2500 <- list()
  for (n in 1:length(plot2500)) {
    x_2500 <- append(x_2500, paste0("(", 2^(n - 1), "-", (2^n) - 1, ")"))
  }
  x_5000 <- list()
  for (m in 1:length(plot5000)) {
    x_5000 <- append(x_5000, paste0("(", 2^(m - 1), "-", (2^m) - 1, ")"))
  }



  png(filename="Challenge_D.png", width = 600, height = 400)
  par(mfrow = c(2, 4))
  # plot your graph here
  barplot(mean_500, names.arg = x_500c, xlab = "number of individuals per species", 
          ylab = "mean of species richness per octave", 
          col = "red", main = "coalesence of size 500")
  barplot(plot500, names.arg = x_500, xlab = "Number of individuals per species",
          ylab = "Mean of abundance octave", col = "red", main = "neutral Model of size 500")

  barplot(mean_1000, names.arg = x_1000c, xlab = "number of individuals per species", 
          ylab = "mean of species richness per octave",
          col = "yellow", main = "coalesence of size 1000")
  barplot(plot1000, names.arg = x_1000, xlab = "Number of individuals per species", 
          ylab = "Mean of abundance octave", col = "yellow", main = "neutral Model of size 1000")

  barplot(mean_2500, names.arg = x_2500c, xlab = "number of individuals per species", 
          ylab = "mean of species richness per octave", 
          col = "blue", main = "coalesence of size 2500")
  barplot(plot2500, names.arg = x_2500, xlab = "Number of individuals per species",
          ylab = "Mean of abundance octave", col = "blue", main = "neutral Model of size 2500")

  barplot(mean_5000, names.arg = x_5000c, xlab = "number of individuals per species", 
          ylab = "mean of species richness per octave", 
          col = "green", main = "coalesence of size 5000")
  barplot(plot5000, names.arg = x_5000, xlab = "Number of individuals per species",
          ylab = "Mean of abundance octave", col = "green", main = "neutral Model of size 5000")

  Sys.sleep(0.1)
  dev.off()
  
  return("cluster takes 11.5 hours while coalescrence takes less than 1 second. Because there is no burn in period so it will save a lot of time.")
}

# Challenge question E
stochastic_simulation_mean_calculation <- function(initial_state,projection_matrix,clutch_distribution,simulation_length){
  population_size <- vector()
  population_size[1] <- sum(initial_state)
  p <- stochastic_recruitment(projection_matrix, clutch_distribution)
  state <- stochastic_step(initial_state, projection_matrix, clutch_distribution, p)

  mean <- vector()
  mean[1] <- population_size[1] / sum(seq(length(initial_state)))

  for (i in seq(simulation_length)) {
    population_size[i + 1] <- sum(state)
    mean[i + 1] <- population_size[i + 1] / sum(seq(length(state)))
    state <- stochastic_step(state, projection_matrix, clutch_distribution, p)
  }
  return(mean)
}


Challenge_E <- function(){
  
  # two initial condition
  adults <- state_initialise_adult(4, 100)
  spread <- state_initialise_spread(4, 100)

  # create the projection matrix
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
  
  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)


  adults_mean <- stochastic_simulation_mean_calculation(adults, projection_matrix, clutch_distribution, 24)
  spread_mean <- stochastic_simulation_mean_calculation(spread, projection_matrix, clutch_distribution, 24)

  png(filename = "Challenge_E.png", width = 600, height = 400)
  # plot your graph here

  plot(x = seq(25), y = adults_mean, type = "l", xlab = "time", col = 2, ylab = "population size", main = "mean life stage of the population changes over time")
  lines(spread_mean, col = 3, type = "l")
  legend("topright", legend = c("100 adults", "100 spread"), fill = 2: 3, title = "type", col = 2: 3)

  Sys.sleep(0.1)
  dev.off()
  
  return("The initial condition of 100 adults rising faster at the beginning, so 100 adults rising faster overall")
}

# Challenge question F
Challenge_F <- function(){
  
  
  
  png(filename="Challenge_F", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}
