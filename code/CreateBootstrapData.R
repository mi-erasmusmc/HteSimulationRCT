#!/usr/bin/env Rscript

# ===================================================
# Description:
#   Generates a dataframe with bootstrap confidence
#   intervals.
# Input:
#   - number of threads for parallelization
# Output:
#   - data/processed/bootstrapData.csv
# Depends:
#   - data/raw/gusto.rda
# ===================================================

library(tidyverse)
library(rms)
library(SmoothHte)
library(ParallelLogger)

set.seed(19910930)


load("data/raw/gusto.rda")
gusto <- gusto %>%
  tibble() %>%
  filter(tx != "SK+tPA") %>%
  rename(
    "outcome" = "day30",
    "treatment" = "tpa"
  )

prediction <- lrm(
  outcome ~ treatment + age + Killip + pmin(sysbp, 120) + lsp(pulse, 50) + pmi + miloc,
  data = gusto,
  maxit = 99
)

riskLinearPredictor <- predict(
  prediction,
  newdata = gusto %>%
    mutate(treatment = 0) %>%
    data.frame()
)

gusto <- gusto %>%
  mutate(
    riskLinearPredictor = riskLinearPredictor
  )

bootstrapConfidenceInterval <- function(x, data) {
  set.seed(19900930 + x)
  originalSampleSize <- nrow(data)
  bootRows <- sample(
    x = 1:originalSampleSize,
    size = originalSampleSize,
    replace = TRUE
  )
  bootData <- data[bootRows, ]
  prediction <- lrm(
    outcome ~ treatment + age + Killip + pmin(sysbp, 120) + lsp(pulse, 50) + pmi + miloc,
    data = bootData,
    maxit = 99
  )

  riskLinearPredictor <- predict(
    prediction,
    newdata = bootData %>%
      dplyr::mutate(treatment = 0) %>%
      data.frame()
  )

  bootData <- bootData %>%
    dplyr::mutate(
      riskLinearPredictor = riskLinearPredictor
    )
  constantModel <- fitModelBasedHte(
    data     = bootData,
    settings = createModelBasedSettings(type = "treatment")
  )
  linearModel <- fitModelBasedHte(
    data     = bootData,
    settings = createModelBasedSettings()
  )

  rcs3Model <- fitRcsHte(
    data     = bootData,
    settings = createRcsSettings()
  )

  stratified <- fitStratifiedHte(
      data     = bootData,
      settings = createStratifiedSettings()
  )

  bootBenefitPredictionsStratified <- stratified$data %>%
    dplyr::rename(
      c(
        "value" = "estimate",
        "risk" = "meanRisk"
      )
    ) %>%
    dplyr::mutate(
      method = "stratified"
    ) %>%
    dplyr::select(riskStratum, value, risk, method)

  bootBenefitPredictionsConstant <- tibble(
    value = predictBenefitModelBasedHte(
      p = seq(.001, .25, length.out = 500),
      constantModel
    ),
    method = "constant",
    risk = seq(.001, .25, length.out = 500)
  )
  bootBenefitPredictionsLinear <- tibble(
    value =  predictBenefitModelBasedHte(
      p = seq(.001, .25, length.out = 500),
      linearModel
    ),
    method = "linear",
    risk = seq(.001, .25, length.out = 500)
  )
  bootBenefitPredictionsRcs <- tibble(
    value = predictBenefitModelBasedHte(
      p = seq(.001, .25, length.out = 500),
      rcs3Model
    ),
    method = "rcs",
    risk = seq(.001, .25, length.out = 500)
  )

  return(
    bind_rows(
      bootBenefitPredictionsConstant,
      bootBenefitPredictionsLinear,
      bootBenefitPredictionsRcs,
      bootBenefitPredictionsStratified
    ) %>%
      mutate(run = x)
  )
}

cl <- ParallelLogger::makeCluster(numberOfThreads = 8)

ParallelLogger::clusterRequire(cl, "dplyr")
ParallelLogger::clusterRequire(cl, "rms")
ParallelLogger::clusterRequire(cl, "SmoothHte")

res <- ParallelLogger::clusterApply(
  x = 1:1e4,
  cl = cl,
  fun = bootstrapConfidenceInterval,
  data = gusto
)

mergedResults <- dplyr::bind_rows(res)

mergedResultsNoStrat <- mergedResults %>%
  filter(is.na(riskStratum)) %>%
  select(-riskStratum)

mergedResultsStrat <- mergedResults %>%
  filter(!is.na(riskStratum))

cisNoStrat <- mergedResultsNoStrat %>%
  group_by(method, risk) %>%
  summarise(
    lower = quantile(value, probs = .025),
    upper = quantile(value, probs = .975)
  ) %>%
  ungroup()

cisStrat <- mergedResultsStrat %>%
  group_by(riskStratum) %>%
  summarise(
    risk = mean(risk),
    lower = quantile(value, probs = .025),
    upper = quantile(value, probs = .975)
  ) %>%
  ungroup() %>%
  mutate(method = "stratified") %>%
  select(-riskStratum) %>%
  relocate(method)

cis <- cisNoStrat %>%
  bind_rows(cisStrat) %>%
  relocate(method, risk, lower, upper)

readr::write_csv(
  cis,
  "data/processed/bootstrapData.csv"
)
