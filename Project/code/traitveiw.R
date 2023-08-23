# This script is for traits data view and preparation for further work.

rm(list = ls())
library('rtry')


trait <- rtry_import('../data/27176.csv')
new_trait <- rtry_remove_col(trait, c('LastName', 'FirstName', 'Reference', 'Comment', 'Dataset'))
byspe <- rtry_explore(new_trait, SpeciesName, TraitID, TraitName, OriglName, OrigValueStr, OrigUnitStr, Replicates, StdValue, UnitName)


# rename the subspecies data
trait$AccSpeciesName[which(trait$AccSpeciesName == "Polygonum aviculare subsp. rurivagum")] <- "Polygonum aviculare"
trait$AccSpeciesName[which(trait$AccSpeciesName == "Vicia sativa subsp. nigra")] <- "Vicia sativa"
trait$AccSpeciesName[which(trait$AccSpeciesName == "Papaver dubium subsp. dubium")] <- "Papaver dubium"
trait$AccSpeciesName[which(trait$AccSpeciesName == "Conyza canadensis")] <- "Erigeron canadensis"

traitdata <- rtry_explore(trait,
                          AccSpeciesID, AccSpeciesName,
                          TraitID, TraitName,
                          OriglName, OrigValueStr, OrigUnitStr,
                          Replicates, StdValue, UnitName,
                          sortBy = AccSpeciesID)

rtry_export(traitdata, '../data/trydata/mytrait_data.csv')


TRYdata3_explore_anc <- rtry_explore(trait,
                          AccSpeciesID, AccSpeciesName,
                          TraitID, TraitName,
                          sortBy = TraitID)
rtry_export(TRYdata3_explore_anc, '../data/trydata/checknumber.csv')