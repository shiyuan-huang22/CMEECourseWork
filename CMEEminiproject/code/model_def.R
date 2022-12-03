# logistic model
logistic_model <- function(t, r_max, K, N_0){ # The classic logistic equation
 return(N_0 * K * exp(r_max * t) / (K + N_0 * (exp(r_max * t) - 1)))
}

# gompertz_model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
 return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}
