# This script is for assessing the trait imputations. See if including phylogenetic tree will improve our imputation

rm(list = ls())
library("funspace")
library("ape")

mytree <- read.tree("../data/phylogenetical_tree/mytree.tre")
trait_data <- read.csv("../data/trydata/merged_df_before_imputation.csv")

# Make sure the species names are consistent
trait_data <- trait_data[, 2:6]
spe_name <- mytree$tip.label
spe_name <- spe_name[order(spe_name)]
row.names(trait_data) <- spe_name

real_result <- trait_data


mysimulation <- function(trait_data, real_result, simulation_time, missing_rate){ # nolint

  result <- data.frame(nrow = simulation_time, ncol = 2) # nolint

  for (i in 1: simulation_time){
    set.seed(i)
    # Create a matrix of missing values with the same dimensions
    missing_df <- trait_data
    non_na_count <- sum(!is.na(missing_df))

    missing_df[!is.na(missing_df)] <- ifelse(runif(non_na_count) <= missing_rate, NA, missing_df[!is.na(missing_df)])

    new_na_count <- non_na_count - sum(!is.na(missing_df)) # nolint
    
    # Perform two types of MissForest imputation
    imputed_df <- impute(traits = missing_df, phylo = NULL, addingSpecies = TRUE)
    imputed_df_phy <- impute(traits = missing_df, phylo = mytree, addingSpecies = TRUE)
    imputed_df <- imputed_df$imputed
    imputed_df_phy <- imputed_df_phy$imputed

    # Calculate RMSE
    rmse <- function(actual, predicted, N) {
      sqrt((1 / N) * sum((actual - predicted)^2, na.rm = TRUE))
    }

    # Convert DataFrame to Matrix
    mat1 <- as.matrix(imputed_df)
    mat2 <- as.matrix(imputed_df_phy)
    mat3 <- as.matrix(real_result)

    # Check data types and handle non-numeric data
    mat1 <- sapply(mat1, as.numeric)
    mat2 <- sapply(mat2, as.numeric)
    mat3 <- sapply(mat3, as.numeric)

    # Calculate RMSE
    rmse_value <- rmse(mat3, mat1, new_na_count)
    rmse_value_phy <- rmse(mat3, mat2, new_na_count)

    # Save RMSE
    result[i, 1] <- rmse_value
    result[i, 2] <- rmse_value_phy

  }
  colnames(result) <- c("RMSE without phylogenetic tree", "RMSE with phylogenetic tree")
  return(result)
}
a <- mysimulation(trait_data, real_result, 1000, 0.2)
write.csv(a, "../result/evaluation.csv")

# Compare the RMSE values of the two MissForests to compare the imputation effects of the two MissForests
comparison <- a[, 2] < a[, 1]
length(which(comparison == TRUE))


# Calculate the mean RMSE of the two methods
eva <- read.csv("../result/evaluation.csv")
no_tree <- mean(eva[, 2])
yes_tree <- mean(eva[, 3])
no_tree
yes_tree
