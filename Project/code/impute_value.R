# This script is for mean calculation of trait data and imputation of missing trait data.

rm(list = ls())
library("rtry")
library("funspace")
library("ape")


traitdata <- read.csv('../data/trydata/mytrait_data.csv')
checkdata <- read.csv('../data/trydata/checknumber.csv')

# Filter data based on traits
seedmass <- rtry_select_row(traitdata, TraitID == 26)
longevity <- rtry_select_row(traitdata, TraitID == 33)
germinationrate <- rtry_select_row(traitdata, TraitID == 95)
temperature <- rtry_select_row(traitdata, TraitID == 353)
Seedbank_duration <- rtry_select_row(traitdata, TraitID == 2809)



fullspecies <- unique(traitdata$AccSpeciesName)
l <- length(fullspecies)

############# seedmass first! #############
spe_list_seedmass <- unique(seedmass$AccSpeciesName)
l_s <- length(spe_list_seedmass)

# calculate the mean of seedmass per species
seedmass_df <- data.frame(species = character(), seedmass = numeric(), stringsAsFactors = FALSE)

for (i in 1:l_s){
    perspe <- rtry_select_row(seedmass, AccSpeciesName == spe_list_seedmass[i])
    spename <- unique(perspe$AccSpeciesName)
    # remove NA in Stdvalue
    StdValue_no_NA <- na.omit(perspe$StdValue)
    mean_s <- mean(StdValue_no_NA)
    temp_df <- data.frame(species = spename, seedmass = mean_s)
    seedmass_df <- rbind(seedmass_df, temp_df)

}

# add missing species for seedmass
for (i in 1:l){
    if (!(fullspecies[i] %in% seedmass_df$species)){
       temp_df <- data.frame(species = fullspecies[i], seedmass = "NaN")
       seedmass_df <- rbind(seedmass_df, temp_df)
    }
}
seedmass_df <- seedmass_df[order(seedmass_df$species), ]
#rtry_export(seedmass_df, '../data/trydata/new_seedmass.csv')


############## longevity second! ############
spe_list_longevity <- unique(longevity$AccSpeciesName)
l_l <- length(spe_list_longevity)

# calculate the mean of longevity per species
longevity_df <- data.frame(species = character(), longevity = numeric(), stringsAsFactors = FALSE)

for (i in 1:l_l){
    perspe <- rtry_select_row(longevity, AccSpeciesName == spe_list_longevity[i])
    spename <- unique(perspe$AccSpeciesName)
    # remove NA in Stdvalue
    StdValue_no_NA <- na.omit(perspe$StdValue)
    mean_s <- mean(StdValue_no_NA)
    temp_df <- data.frame(species = spename, longevity = mean_s)
    longevity_df <- rbind(longevity_df, temp_df)

}

# add missing species for longevity
for (i in 1:l){
    if (!(fullspecies[i] %in% longevity_df$species)){
       temp_df <- data.frame(species = fullspecies[i], longevity = "NaN")
       longevity_df <- rbind(longevity_df, temp_df)
    }
}
longevity_df <- longevity_df[order(longevity_df$species), ]
#rtry_export(longevity_df, '../data/trydata/new_longevity.csv')


######### germinationrate third! ##########
spe_list_germinationrate <- unique(germinationrate$AccSpeciesName)
l_gr <- length(spe_list_germinationrate)

# calculate the mean of germinationrate per species
germinationrate_df <- data.frame(species = character(), germinationrate = numeric(), stringsAsFactors = FALSE)

for (i in 1:l_gr){
    perspe <- rtry_select_row(germinationrate, AccSpeciesName == spe_list_germinationrate[i])
    spename <- unique(perspe$AccSpeciesName)
    # remove NA in Stdvalue
    StdValue_no_NA <- na.omit(perspe$StdValue)
    mean_s <- mean(StdValue_no_NA)
    temp_df <- data.frame(species = spename, germinationrate = mean_s)
    germinationrate_df <- rbind(germinationrate_df, temp_df)

}

# add missing species for germinationrate
for (i in 1:l){
    if (!(fullspecies[i] %in% germinationrate_df$species)){
       temp_df <- data.frame(species = fullspecies[i], germinationrate = "NaN")
       germinationrate_df <- rbind(germinationrate_df, temp_df)
    }
}
germinationrate_df <- germinationrate_df[order(germinationrate_df$species), ]
#rtry_export(germinationrate_df, '../data/trydata/new_germinationrate.csv')




########## germination temperature fourth! ###########
spe_list_temperature <- unique(temperature$AccSpeciesName)
l_t <- length(spe_list_temperature)

# calculate the mean of germination temperature per species
temperature_df <- data.frame(species = character(), temperature = numeric(), stringsAsFactors = FALSE)

for (i in 1:l_t){
    perspe <- rtry_select_row(temperature, AccSpeciesName == spe_list_temperature[i])
    spename <- unique(perspe$AccSpeciesName)
    # remove NA in Stdvalue
    StdValue_no_NA <- na.omit(perspe$StdValue)
    mean_s <- mean(StdValue_no_NA)
    temp_df <- data.frame(species = spename, temperature = mean_s)
    temperature_df <- rbind(temperature_df, temp_df)

}

# add missing species for Seedbank_duration
for (i in 1:l){
    if (!(fullspecies[i] %in% temperature_df$species)){
       temp_df <- data.frame(species = fullspecies[i], temperature = "NaN")
       temperature_df <- rbind(temperature_df, temp_df)
    }
}
temperature_df <- temperature_df[order(temperature_df$species), ]
#rtry_export(temperature_df, '../data/trydata/new_temperature.csv')


######## Seedbank_duration fifth!########
spe_list_Seedbank_duration <- unique(Seedbank_duration$AccSpeciesName)
l_d <- length(spe_list_Seedbank_duration)

# calculate the mean of Seedbank_duration pRphyloparser species
Seedbank_duration_df <- data.frame(species = character(), Seedbank_duration = numeric(), stringsAsFactors = FALSE)

for (i in 1:l_d){
    perspe <- rtry_select_row(Seedbank_duration, AccSpeciesName == spe_list_Seedbank_duration[i])
    spename <- unique(perspe$AccSpeciesName)
    # remove NA in Stdvalue
    StdValue_no_NA <- na.omit(perspe$StdValue)
    mean_s <- mean(StdValue_no_NA)
    temp_df <- data.frame(species = spename, Seedbank_duration = mean_s)
    Seedbank_duration_df <- rbind(Seedbank_duration_df, temp_df)

}

# add missing species for Seedbank_duration
for (i in 1:l){
    if (!(fullspecies[i] %in% Seedbank_duration_df$species)){
       temp_df <- data.frame(species = fullspecies[i], Seedbank_duration = "NaN")
       Seedbank_duration_df <- rbind(Seedbank_duration_df, temp_df)
    }
}
Seedbank_duration_df <- Seedbank_duration_df[order(Seedbank_duration_df$species), ]
#rtry_export(Seedbank_duration_df, '../data/trydata/new_Seedbank_duration.csv')





############################## create a dataframe contains all trait data #########################

# check if the order is the same
checkdf <- cbind(seedmass_df$species, longevity_df$species, germinationrate_df$species, temperature_df$species, Seedbank_duration_df$species)

# Merge DataFrame
merged_df <- cbind(as.double(seedmass_df$seedmass), as.double(longevity_df$longevity),
                   as.double(germinationrate_df$germinationrate),
                   as.double(temperature_df$temperature), as.double(Seedbank_duration_df$Seedbank_duration))

# Print the merged DataFrame
merged_df[merged_df == 0] <- NA
merged_df[merged_df == "NaN"] <- NA

# Z normalization using the scale function

merged_scale <- scale(merged_df, center = TRUE, scale = TRUE)

# unscaled trait dataframe
merged_unscale <- merged_df


# imputation
# now impute


mytree <- read.tree("../data/phylogenetical_tree/mytree.tre")
spe_name <- mytree$tip.label

spe_name <- spe_name[order(spe_name)]
row.names(merged_scale) <- spe_name
colnames(merged_scale) <- c("seedmass", "longevity", "germination_rate", "temperature", "seedbank_duration")
write.csv(merged_scale, "../data/trydata/merged_df_before_imputation.csv")

row.names(merged_unscale) <- spe_name
colnames(merged_unscale) <- c("seedmass", "longevity", "germination_rate", "temperature", "seedbank_duration")

set.seed(123)

imputed_result_scaled <- impute(merged_scale, phylo = mytree, addingSpecies = TRUE)
imputed_result_unscaled <- impute(merged_unscale, phylo = mytree, addingSpecies = TRUE)


write.csv(imputed_result_scaled$imputed, "../data/trydata/scaled_imputed_result_by_missForest_with_phylogenetic_tree.csv")
write.csv(imputed_result_unscaled$imputed, "../data/trydata/unscaled_imputed_result_by_missForest_with_phylogenetic_tree.csv")