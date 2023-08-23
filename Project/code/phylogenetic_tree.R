# This script is for building phylogenetic tree which will be used in imputation of missing trait values

rm(list = ls())
library("V.PhyloMaker2")
library("ape")

# input the sample species list

example <- read.csv("../data/phylogenetical_tree/species.csv")

# generate a phylogeny for the sample species list

tree <- phylo.maker(sp.list = example, tree = GBOTB.extended.TPL, nodes = nodes.info.1.TPL, scenarios = "S3")

write.tree(tree$scenario.3, "../data/phylogenetical_tree/mytree.tre")
