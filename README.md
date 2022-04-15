# Individualized treatment effect was predicted best by modeling baseline risk in interaction with treatment assignment

## Summary
**Objective**: To compare different risk-based methods for optimal prediction
of treatment effects. **Study Design and Setting**: We simulated RCT data
using diverse assumptions for the average treatment effect, a baseline
prognostic index of risk (PI), the shape of its interaction with treatment
(none, linear, quadratic or non-monotonic), and the magnitude of
treatment-related harms (none or constant independent of the PI). We predicted
absolute benefit using: models with a constant relative treatment effect;
stratification in quarters of the PI; models including a linear interaction of
treatment with the PI; models including an interaction of treatment with a
restricted cubic spline (RCS) transformation of the PI; an adaptive approach
using Akaike’s Information Criterion. We evaluated predictive performance
using root mean squared error and measures of discrimination and calibration
for benefit. **Results**: The linear-interaction model displayed optimal or
close-to-optimal performance across many simulation scenarios with moderate
sample size (N=4,250; ~800 events). The RCS-model was optimal for strong
non-linear deviations from a constant treatment effect, particularly when
sample size was larger (N=17,000). The adaptive approach also required larger
sample sizes. These findings were illustrated in the GUSTO-I
trial. **Conclusion**: An interaction between baseline risk and treatment
assignment should be considered to improve treatment effect predictions.

## Overview

```
project
|- README                 # Project description (this document)
|- LICENSE                # License of this project
|
|- code/                  # Any code used for generating the results
|                         # and manuscript
|
|- data/                  # Raw and processed data
| |- raw/                 # Simulation results and raw RCT data
| +- processed/           # Evaluation metrics (published)
|
|- figures/               # Any figures used in the manuscript
|                         # not published
|
|- extras
| |- bookdown/            # Project website source code
| |- vignettes/           # Instructions on running the simulations
| |- shiny/               # Shiny application code
| | |- html/
| | |- global.R
| | |- server.R
| | +- ui.R
|
|- docs/                  # Website material
|
|- submission/            # Source code of the manuscript
| |- manuscript.rmd
| |- supplement.rmd
| |- references.bib
| +- jce.csl
|
|- renv/                  # Files required for setting up renv
|- renv.lock              # Lock file for freezing R-package versions
+- Makefile               # Recipes for creating all required project files
```


## Replication

To explore the simulation results locally, first clone the repository:
```bash
git clone https://github.com/mi-erasmusmc/HteSimulationRCT.git
```

The evaluation metrics for each simulation run can be found in the `csv` files
in `data/processed` directory.

You can also replicate the study by running:
```bash
make clean
make submission/manuscript.pdf
```
This will start the entire simulation study from scratch and may take a while to complete.
R-package `renv` is used to recreate our R environment, to allow for reproducible research.
To adjust the settings of the simulation edit `code/SimulationScript.R`. You can increase 
or reduce the resources allocated to the task or alter the settings of the simulations
altogether.


## Requirements

The simulation study used
[renv](https://rstudio.github.io/renv/articles/renv.html) R-package for freezing
R-related dependencies. Launching the `RProject` will regenerate the development
environment.

The code for running the simulations is contained in 3 custom R-packages:

- [SimulateHte](https://github.com/rekkasa/SimulateHte) generating the simulated
  datasets.
- [SmoothHte](https://github.com/rekkasa/SmoothHte) for fitting smooth
  interactions of baseline risk with treatment assignement.
- [SimulationEvaluationHte](https://github.com/rekkasa/SimulationEvaluationHte)
  for computing evaluation metrics for every simulation run.
