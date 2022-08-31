#!/usr/bin/env Rscript

# ===================================================
# Description:
#   Generates the plot for gusto trial.
# Input:
# Output:
#   - figures/gusto.tiff
# Depends:
#   - data/raw/gusto.rda
#   - data/processed/bootstrapData.csv
# ===================================================

library(tidyverse)
library(rms)
library(SmoothHte)

maxRisk <- .25

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
bootstrapData <- readr::read_csv("data/processed/bootstrapData.csv")

constantModel <- fitModelBasedHte(
  data     = gusto, 
  settings = createModelBasedSettings(type = "treatment")
)

stratified <- fitStratifiedHte(
  data     = gusto,
  settings = createStratifiedSettings()
)

linearModel <- fitModelBasedHte(
  data     = gusto,
  settings = createModelBasedSettings()
)

rcs3Model <- fitRcsHte(
  data     = gusto,
  settings = createRcsSettings()
)

scale_custom <- list(
  scale_color_manual(
    values = c(
      "#40ba31",
      "#969A97",
      "#4d9de0",
      "#d1495b"
    ),
    breaks = c(
      "Constant treatment effect",
      "Stratified",
      "Linear interaction",
      "RCS 3 knots"
    )
  ),
  scale_fill_manual(
    values = c(
      "#40ba31",
      "#4d9de0",
      "#d1495b"
    ),
    breaks = c(
      "Constant treatment effect",
      "Linear interaction",
      "RCS 3 knots"
    )
  ),
  scale_linetype_manual(
    values = c("dashed", "solid", "solid"),
    breaks = c(
      "Constant treatment effect",
      "Linear interaction",
      "RCS 3 knots"
    ),
    guide = "none"
  )
)

plot <- ggplot() +
  geom_pointrange(
    data = stratified$data,
    aes(
      x     = meanRisk,
      y     = estimate,
      ymin  = lower,
      ymax  = upper,
      color = "Stratified"
    ),
    key_glyph = "rect"
  ) +
  stat_function(
    data = data.frame(
      x     = c(.001, maxRisk),
      label = "Constant treatment effect"
    ),
    aes(
      x     = x, 
      color = label,
      linetype = label
    ),
    size = .95,
    alpha = .8,
    fun  = predictBenefitModelBasedHte,
    args = list(
      modelBasedFit = constantModel
    )
  ) +
  geom_ribbon(
      data = bootstrapData %>%
        filter(method == "constant") %>%
        rename("x" = "risk") %>%
        mutate(label = "Constant treatment effect"),
    aes(ymin = lower, ymax = upper, x = x, fill = label),
    alpha = .1,
    color = NA,
    outline.type = "full",
    show.legend = FALSE
  ) +
  stat_function(
    data = data.frame(
      x = c(.001, maxRisk), 
      label = "Linear interaction"
    ),
    aes(
      x     = x,
      linetype = label,
      color = label
    ),
    size = .95,
    fun  = predictBenefitModelBasedHte,
    args = list(
      modelBasedFit = linearModel
    )
  ) +
  geom_ribbon(
    data = bootstrapData %>%
      filter(method == "linear") %>%
      rename("x" = "risk") %>%
      mutate(label = "Linear interaction"),
    aes(ymin = lower, ymax = upper, x = x, fill = label),
    alpha = .1,
    color = NA,
    outline.type = "full",
    show.legend = FALSE
  ) +
  stat_function(
    data = data.frame(
      x = c(.001, maxRisk),
      label = "RCS 3 knots"
    ),
    aes(
      x     = x,
      color = label,
      linetype = label
    ),
    size = .95,
    fun  = predictSmoothBenefit,
    args = list(
      smoothFit = rcs3Model
    )
  ) +
  geom_ribbon(
    data = bootstrapData %>%
      filter(method == "rcs") %>%
      rename("x" = "risk") %>%
      mutate(label = "RCS 3 knots"),
    aes(ymin = lower, ymax = upper, x = x, fill = label),
    alpha = .1,
    color = NA,
    outline.type = "full",
    show.legend = FALSE
  ) +
  scale_custom +
  xlab("Baseline risk") +
  ylab("Predicted benefit") +
  theme_classic() +
  theme(
    legend.title = element_blank(),
    axis.text.x = ggplot2::element_text(size = 12),
    axis.text.y = ggplot2::element_text(size = 12),
    axis.title = ggplot2::element_text(size = 14),
    legend.text = element_text(size = 10),
    legend.position = c(.17, .85)
  )

 ggplot2::ggsave(
    file.path("figures", "gusto.tiff"), 
    plot = plot,
    dpi = 1200,
    width = 7, 
    height = 5,
    compression = "lzw"
  )
  
