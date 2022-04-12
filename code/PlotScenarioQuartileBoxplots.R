#!/usr/bin/env Rscript

# ==========================================================================
# Description:
#   Generates boxplots of simulation scenarios that resemble the plots
#   shown in Kent, et al. 2016
# Input:
#   - scenario id
# Output:
#   - figures/scenario_XXX.tiff
# Depends:
#   - data/processed/analysisIds.csv
# ==========================================================================

set.seed(19910930)

library(tidyverse)
library(SimulateHte)

args <- commandArgs(trailingOnly = TRUE)
selectedScenario <- as.integer(args[1])

analysisIds <- readr::read_csv("data/processed/analysisIds.csv")

idSettings <- analysisIds %>%
  filter(scenario == selectedScenario)

if (idSettings$base != "absent") {
  harm <- case_when(
    idSettings$harm == "moderate-positive" ~ idSettings$averageTrueBenefit / 4, 
    idSettings$harm == "strong-positive"   ~ idSettings$averageTrueBenefit / 2, 
    idSettings$harm == "negative"          ~ -idSettings$averageTrueBenefit / 4, 
    TRUE                                   ~ 0
  )
} else {
  harm <- case_when(
    idSettings$harm == "moderate-positive" ~ .01,
    idSettings$harm == "strong-positive"   ~ .02,
    idSettings$harm == "negative"          ~ -.01,
    TRUE                                   ~ 0
  )
}
  
  createF1 <- function(c) function(x) x - c
  createF2 <- function(c) function(x) (x - c)^2
  treatmentEffectSettings <- SimulateHte::createTreatmentEffectSettings(
    type = "lp",
    harm = harm,
    modelSettings = SimulateHte::createModelSettings(
      constant = idSettings$g0,
      modelMatrix = matrix(c(1, 1)),
      transformationSettings = list(
        createF1(idSettings$c),
        createF2(idSettings$c)
      ),
      coefficients = c(
        idSettings$g1,
        idSettings$g2
      )
    )
  )
databaseSettings <- SimulateHte::createDatabaseSettings(
  numberOfObservations = 4e4,
  numberOfCovariates = 8,
  covariateDistributionSettings = list(
    SimulateHte::createNormalDistributionSettings(),
    SimulateHte::createNormalDistributionSettings(),
    SimulateHte::createNormalDistributionSettings(),
    SimulateHte::createNormalDistributionSettings(),
    SimulateHte::createBinomialDistributionSettings(prob = .2),
    SimulateHte::createBinomialDistributionSettings(prob = .2),
    SimulateHte::createBinomialDistributionSettings(prob = .2),
    SimulateHte::createBinomialDistributionSettings(prob = .2)
  )
)

baselineRiskSettings <- SimulateHte::createBaselineRiskSettings(
  type = "binary",
  modelSettings = SimulateHte::createModelSettings(
    constant = idSettings %>% pull(b0),
    modelMatrix = diag(8),
    transformationSettings = list(
      identity,
      identity,
      identity,
      identity,
      identity,
      identity,
      identity,
      identity
    ),
    coefficients = idSettings %>% select(paste0("b", 1:8)) %>% unlist()
  )
)


propensitySettings <- SimulateHte::createPropensitySettings(
  type = "binary",
  modelSettings = SimulateHte::createModelSettings(
    constant = 0,
    modelMatrix = diag(0),
    transformationSettings = NULL
  )
)

simulatedDataset <- runDataGeneration(
  databaseSettings = databaseSettings,
  propensitySettings = propensitySettings,
  baselineRiskSettings = baselineRiskSettings,
  treatmentEffectSettings = treatmentEffectSettings
) %>%
  mutate(
    untreatedRisk = plogis(untreatedRiskLinearPredictor),
    riskQuarter = factor(
      Hmisc::cut2(untreatedRisk, g = 4), labels = as.character(1:4)),
    trueBenefit = 100 * trueBenefit
  )

res <- ggplot(
  data = simulatedDataset,
  aes(
    x = riskQuarter,
    y = trueBenefit
  )
) +
  geom_boxplot() +
  xlab("Risk quarter") +
  ylab("True benefit (%)") +
  theme_linedraw()

fileName <- paste0(
  paste("scenario", selectedScenario, sep = "_"),
  ".png"
)
  
ggsave(
  file.path("figures", fileName),
  plot = res,
  dpi = 1200,
  width = 8, 
  height = 8
)
