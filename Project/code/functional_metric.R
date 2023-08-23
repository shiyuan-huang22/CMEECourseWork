# This script is for visulization of functional trait space and also calculating functional diversity metric,
# and also fitting linear mixed model of different trait and functional diversity metric

rm(list = ls())
library(fundiversity)
library(tidyr)
library(BAT)
library(dplyr)
library(factoextra)
library(funspace)
library(lme4)
library(emmeans)
library(MuMIn)
library(ggeffects)
library(see)

data <- read.csv('../data/PoundHillDist_cover.csv', header = TRUE)

# remove "bare groud" which is not a species
data <- data[data$taxa != "bare_ground", ]

# Make sure species names of two dataframe are same
data$taxa[which(data$taxa == "Polygonum_rurivagum")] <- "Polygonum_aviculare"
data$taxa[which(data$taxa == "Vicia_sativa_nigra")] <- "Vicia_sativa"
data$taxa[which(data$taxa == "Papaver_dubium_dubium")] <- "Papaver_dubium"
data$taxa[which(data$taxa == "Conyza_canadensis")] <- "Erigeron_canadensis"
data$taxa[which(data$taxa == "Raphanus_raphanistrum_raphanistrum")] <- "Raphanus_raphanistrum"
data$taxa[which(data$taxa == "Arenaria_serpyllifolia_leptoclados")] <- "Arenaria_serpyllifolia"
data$taxa[which(data$taxa == "Veronica_arvensis")] <- "Veronica_arvensis_"
data$taxa[which(data$taxa == "Prunus_sp.")] <- "Prunus_spinosa"
data$taxa[which(data$taxa == "Elytrigia_repens")] <- "Elymus_repens"
data$taxa[which(data$taxa == "Apera_spica.venti")] <- "Apera_spica-venti"
data$taxa[which(data$taxa == "Capsella_bursa.pastoris")] <- "Capsella_bursa-pastoris"

data <- data[order(data$taxa), ]


# Check species names
unique(data$taxa) #no spelling errors

#need to edit the taxa names to match the species in the species x trait data frame.
#after this step then we can use pivot_wider

#Pivot_wider wasn't working because there was a duplicate, but removing note_cover first
data_wo_note <- data %>% select(-note_cover)
data_wo_note[duplicated(data_wo_note), ] #there is one duplicate so let's remove this 
data_no_dup <- unique(data_wo_note)
data4 <- data_no_dup
data4$row <- 1:nrow(data4) # nolint
wide_data <- pivot_wider(data4, names_from = taxa, values_from = cover, values_fill = list(cover=0)) %>%
  group_by(site, year, date, block, plot, month, collectors) %>% summarise_at(vars(Achillea_millefolium:Vulpia_myuros), sum)

#looking at the wide data there is only 4 recordings for 2014 when we want each of our sites sample so that would be 12. We'll remove 2014
wide_data_wo_2014 <- subset(wide_data, year != 2014)
write.csv(wide_data_wo_2014, "../data/trydata/abun.csv")

#Total abundance
colnames(wide_data_wo_2014)
wide_data_wo_2014$tot_abun <- rowSums(wide_data_wo_2014[, 8:85])
wide_data_wo_2014$spe_count <- apply(wide_data_wo_2014[, 8:85], 1, function(row) sum(row != 0))

rel_abun <- wide_data_wo_2014
rel_abun[,8:85] <- t(apply(rel_abun[,8:85],1, function(x) x/sum(x))) #creates dataframe with relative abundances


#we now have a data frame with 60 sites in total

write.csv(rel_abun, '../data/trydata/rel_abun.csv')

traitdata <- read.csv('../data/trydata/scaled_imputed_result_by_missForest_with_phylogenetic_tree.csv',  header = TRUE)
traitdata <- traitdata[traitdata$X != "Arenaria_leptoclados", ]
row.names(traitdata) <- traitdata[, 1]
traitdata <- traitdata[, 2:6]


list1 <- colnames(rel_abun[, 8:85])
list2 <- row.names(traitdata)


# check if the species are identical
if (identical(list1, list2)) {
  print("two lists are identical")
} else {
  unequal_elements <- list(setdiff(list1, list2), setdiff(list2, list1))
  print("two lists are not identical")
  print(unequal_elements)
}

# Perform PCA on 5 traits
pca <- princomp(traitdata, cor = TRUE)
summary(pca)
loadings(pca)
eigenvalues <- pca$sdev^2
eigenvalues

total_variance <- sum(eigenvalues)
variation_explained <- eigenvalues / total_variance

png("../result/plot/pca_plot.png", width = 7, height = 7, units = "in", res = 300)
fviz_pca_biplot(pca, repel = TRUE, geom.ind = "point", ellipse.level = 0.95, col.var = "black", labelsize = 4)
dev.off()


scores <- cbind(traitdata, pca$scores[, c(1, 2)])
myscores <- scores[, 6:7]

# Calculation of Functional Diversity Metrics
fric <- fd_fric(myscores, rel_abun)
fdiv <- fd_fdiv(myscores, rel_abun)
feve <- fd_feve(myscores, rel_abun)

# Calculation of CWM for 5 traits
mycwm <- cwm(rel_abun[, 8:85], traitdata)

pca_cwm <- princomp(mycwm, cor = TRUE)
pca_cwm$month <- rel_abun$month
pca_cwm$year <- rel_abun$year
pca_cwm$block <- rel_abun$block
pca_cwm$plot <- rel_abun$plot


# Building a functional trait space grouped by month of cultivation
trait_space_month <- funspace(x = pca_cwm, group.vec = rel_abun$month, PCs = c(1,2), n_divisions = 300)
summary(trait_space_month)

png("../result/plot/traitspace_global.png", width = 7, height = 7, units = "in", res = 300)
plot(x = trait_space_month, #funspace object
  type = "global", #plot the global TPD
  quant.plot = TRUE, #add quantile lines
  arrows = TRUE, #add arrows for PCA loadings
  arrows.length = 0.9) # make arrows a bit shorter than the default.
dev.off()

# Build a global functional trait space
png("../result/plot/traitspace_groups.png", width = 10, height = 4, units = "in", res = 300)
plot(x = trait_space_month,
  type = "groups", #a plot for each group (family)
  quant.plot = TRUE,
  globalContour = T, #The contour of the global TPD
  arrows = TRUE, #add arrows for PCA loadings
  arrows.length = 0.9,
  pnt = T, #add points for species of each family
  pnt.cex = 0.1, #points should be small
  pnt.col = rgb(0.2, 0.8, 0.1, alpha = 0.2)) #color for points
dev.off()


# Establishment of linear mixed models for functional diversity metrics and CWM for five traits
model_fric <- lmer(fric[, 2] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/fric_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_fric, main = "FRic")
dev.off()
png("../result/plot/fric_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_fric), main = "FRic")
dev.off()


model_feve <- lmer(feve[, 2] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/feve_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_feve, main = "FEve")
dev.off()
png("../result/plot/feve_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_feve), main = "FEve")
dev.off()


model_fdiv <- lmer(fdiv[, 2] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/fdiv_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_fdiv, main = "FDiv")
dev.off()
png("../result/plot/fdiv_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_fdiv), main = "FDiv")
dev.off()


model_cwm_seedmass <- lmer(mycwm[, 1] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/cwm_seedmass_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_cwm_seedmass, main = "Seed dry mass")
dev.off()
png("../result/plot/cwm_seedmass_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_cwm_seedmass), main = "Seed dry mass")
dev.off()


model_cwm_longevity <- lmer(mycwm[, 2] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/cwm_longevity_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_cwm_longevity, main = "Seed longevity")
dev.off()
png("../result/plot/cwm_longevity_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_cwm_longevity), main = "Seed longevity")
dev.off()


model_cwm_ger_rate <- lmer(mycwm[, 3] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/cwm_ger_rate_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_cwm_ger_rate, main = "Germination rate")
dev.off()
png("../result/plot/cwm_ger_rate_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_cwm_ger_rate), main = "Germination rate")
dev.off()


model_cwm_temp <- lmer(mycwm[, 4] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/cwm_temp_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_cwm_temp, main = "Germination temperature")
dev.off()
png("../result/plot/cwm_temp_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_cwm_temp), main = "Germination temperature")
dev.off()


model_cwm_sb_dur<- lmer(mycwm[, 5] ~ month + (1 | block) + (1 | year), data = rel_abun)

png("../result/plot/cwm_sb_dur_plot.png", width = 7, height = 7, units = "in", res = 300)
plot(model_cwm_sb_dur, main = "Seedbank duration")
dev.off()
png("../result/plot/cwm_sb_dur_hist.png", width = 7, height = 7, units = "in", res = 300)
hist(resid(model_cwm_sb_dur), main = "Seedbank duration")
dev.off()


# Save summaries, confident intervals and estimated marginal means of linear mixed model of functional diversity indices

writeLines(capture.output(summary(model_fric)), "../result/lmer/fric_lmer_summary.txt")
writeLines(capture.output(summary(model_fdiv)), "../result/lmer/fdiv_lmer_summary.txt")
writeLines(capture.output(summary(model_feve)), "../result/lmer/feve_lmer_summary.txt")


emmeans_fric <- emmeans(model_fric, pairwise ~ month, lmer.df = "satterthwaite")
emmeans_feve <- emmeans(model_fdiv, pairwise ~ month, lmer.df = "satterthwaite")
emmeans_fdiv <- emmeans(model_feve, pairwise ~ month, lmer.df = "satterthwaite")

writeLines(capture.output(emmeans_fric), "../result/emmeans/fric_emmean.txt")
writeLines(capture.output(emmeans_feve), "../result/emmeans/fdiv_emmean.txt")
writeLines(capture.output(emmeans_fdiv), "../result/emmeans/feve_emmean.txt")



# Save summaries, confident intervals and estimated marginal means of linear mixed model of CWMs

writeLines(capture.output(summary(model_cwm_seedmass)), "../result/lmer/seedmass_lmer_summary.txt")
writeLines(capture.output(summary(model_cwm_longevity)), "../result/lmer/longevity_lmer_summary.txt")
writeLines(capture.output(summary(model_cwm_ger_rate)), "../result/lmer/gerrate_lmer_summary.txt")
writeLines(capture.output(summary(model_cwm_temp)), "../result/lmer/temp_lmer_summary.txt")
writeLines(capture.output(summary(model_cwm_sb_dur)), "../result/lmer/sbdur_lmer_summary.txt")



emmeans_cwm_seedmass <- emmeans(model_cwm_seedmass, pairwise ~ month, lmer.df = "satterthwaite")
emmeans_cwm_longevity <- emmeans(model_cwm_longevity, pairwise ~ month, lmer.df = "satterthwaite")
emmeans_cwm_ger_rate <- emmeans(model_cwm_ger_rate, pairwise ~ month, lmer.df = "satterthwaite")
emmeans_cwm_temp <- emmeans(model_cwm_temp, pairwise ~ month, lmer.df = "satterthwaite")
emmeans_cwm_sd_dur <- emmeans(model_cwm_sb_dur, pairwise ~ month, lmer.df = "satterthwaite")

writeLines(capture.output(emmeans_cwm_seedmass), "../result/emmeans/seedmass_emmean.txt")
writeLines(capture.output(emmeans_cwm_longevity), "../result/emmeans/longevity_emmean.txt")
writeLines(capture.output(emmeans_cwm_ger_rate), "../result/emmeans/ger_rate_emmean.txt")
writeLines(capture.output(emmeans_cwm_temp), "../result/emmeans/temp_emmean.txt")
writeLines(capture.output(emmeans_cwm_sd_dur), "../result/emmeans/sb_dur_emmean.txt")

# Calculate estimated marginal means, including confidence intervals
g1 <- ggemmeans(model_cwm_seedmass, terms = ~ month)
g2 <- ggemmeans(model_cwm_longevity, terms = ~ month)
g3 <- ggemmeans(model_cwm_ger_rate, terms = ~ month)
g4 <- ggemmeans(model_cwm_temp, terms = ~ month)
g5 <- ggemmeans(model_cwm_sb_dur, terms = ~ month)
g6 <- ggemmeans(model_fric, terms = ~ month)
g7 <- ggemmeans(model_feve, terms = ~ month)
g8 <- ggemmeans(model_fdiv, terms = ~ month)

mycwm_plot <- as.data.frame(mycwm)
month <- rel_abun$month
mycwm_plot <- cbind(mycwm_plot, month)

# Draw a graph of estimated marginal means, including confidence intervals
# For CWMs
p1 <- ggplot(g1, aes(x = x, y = predicted)) +
  geom_point(data = mycwm_plot, aes(x = month, y = seedmass), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("Z-Seed Mass")
p2 <- ggplot(g2, aes(x = x, y = predicted)) +
  geom_point(data = mycwm_plot, aes(x = month, y = longevity), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("Z-Seed Longevity")
p3 <- ggplot(g3, aes(x = x, y = predicted)) +
  geom_point(data = mycwm_plot, aes(x = month, y = germination_rate), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("Z-Seed Germination Rate")
p4 <- ggplot(g4, aes(x = x, y = predicted)) +
  geom_point(data = mycwm_plot, aes(x = month, y = temperature), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("Z-Seed Germination Temperature")
p5 <- ggplot(g5, aes(x = x, y = predicted)) +
  geom_point(data = mycwm_plot, aes(x = month, y = seedbank_duration), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("Z-Seedbank Duration")

png("../result/plot/emmeans_traits.png", width = 10, height = 8, units = "in", res = 300)
plots(p1, p2, p3, p4, p5, n_rows = 2, tags = c("seedmass", "longevity", "germination rate", "temperature", "seedbank duration"))
dev.off()

# For functional diversity metrics
metrics_plot <- as.data.frame(fric$FRic)
metrics_plot <- cbind(metrics_plot, as.data.frame(feve$FEve), as.data.frame(fdiv$FDiv), month)

p6 <- ggplot(g6, aes(x = x, y = predicted)) +
  geom_point(data = metrics_plot, aes(x = month, y = fric$FRic), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("FRic")
p7 <- ggplot(g7, aes(x = x, y = predicted)) +
  geom_point(data = metrics_plot, aes(x = month, y = feve$FEve), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("FEve")
p8 <- ggplot(g8, aes(x = x, y = predicted)) +
  geom_point(data = metrics_plot, aes(x = month, y = fdiv$FDiv), color = "#00ff22", alpha = 0.7) +
  geom_point() +
  geom_errorbar(mapping = aes(ymin = conf.low, ymax = conf.high), width = 0.25) +
  xlab("Month") +
  ylab("FDiv")

png("../result/plot/emmeans_metrics.png", width = 10, height = 4, units = "in", res = 300)
plots(p6, p7, p8, n_rows = 1, tags = c("FRic", "FEve", "FDiv"))
dev.off()

# Calculate Pseudo-R-squared for Generalized Mixed-Effect models
r.squaredGLMM(model_cwm_seedmass)
r.squaredGLMM(model_cwm_longevity)
r.squaredGLMM(model_cwm_ger_rate)
r.squaredGLMM(model_cwm_temp)
r.squaredGLMM(model_cwm_sb_dur)

r.squaredGLMM(model_fric)
r.squaredGLMM(model_feve)
r.squaredGLMM(model_fdiv)


