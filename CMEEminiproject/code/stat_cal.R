# RSS for log scale transfer to linear scale
NonLogRSS <- function(n, predictions, subset) {
  
  exp_predictions <- exp(predictions)

  residuals <- subset$PopBio - exp_predictions
  RSS <- sum(residuals ^ 2)

  return(RSS)
}

# RSS for linear scale transfor to log scale
LMRSS <- function(n, predictions, subset) {
  
  residuals <- subset$PopBio - predictions
  RSS <- sum(residuals ^ 2)

  return(RSS)
}

# AICc
MyAICc <- function(n, RSS, p) {
  return(n + 2 + n * log(2 * pi / n) + n * log(RSS) + 2 * p) + ((2 * p * (p + 1)) / (n - p - 1))
}

# BIC
MyBIC <- function(n, RSS, p) {
  return(n + 2 + n * log(2 * pi / n) + n * log(RSS) + p * log(n))
}