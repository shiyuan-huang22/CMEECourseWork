## Script to get names of species from PoundHillDist_cover.csv file

rm(list = ls())


trydata <- read.csv('../data/PoundHillDist_cover.csv', header = TRUE)
species <- unique(trydata$taxa)

# Get a list of species names from PoundHillDist_cover.csv and count species IDs and traits
for (i in 1:80){
  species[i] <- gsub("_", " ", species[i])
}

TRY <- read.csv('../data/TryAccSpecies.csv', header = TRUE, sep = '\t')
head(TRY)


AccSpeciesName <- rep(NA)
AccSpeciesID <- rep(NA)
TraitNum <- rep(NA)

# Get the list of species with corresponding IO and Trait numbers in TRY
for (i in length(species)) {
    for (n in 1:300999){
      if (isTRUE(TRY$AccSpeciesName[n] == species[i])){
        AccSpeciesName[i] <- species[i]
        AccSpeciesID[i] <- TRY$AccSpeciesID[n]
        TraitNum[i] <- TRY$TraitNum[n]
      }
    }
}

MYspecies <- cbind(AccSpeciesName, AccSpeciesID, TraitNum)
MYspecies


