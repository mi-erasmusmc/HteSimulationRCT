--- 
author: Alexandros Rekkas
date: "2022-04-12"
site: bookdown::bookdown_site
documentclass: book
biblio-style: apalike
bibliography: [ "references.bib" ]
link-citations: true
csl: jce.csl
---

% Pandoc header
\renewcommand*\familydefault{\sfdefault}
\usepackage{setspace}
\usepackage{amsmath}
\doublespacing
\usepackage{amssymb}
\usepackage{caption}
\usepackage{booktabs}
\date{}
\newcommand\given[1][]{\:#1\vert\:}
\newcommand{\indep}{\perp \!\!\! \perp}
\usepackage{booktabs}
\usepackage{longtable}
\usepackage{array}
\usepackage{multirow}
\usepackage{wrapfig}
\usepackage{float}
\usepackage{colortbl}
\usepackage{pdflscape}
\usepackage{tabu}
\usepackage{threeparttable}
\usepackage{threeparttablex}
\usepackage[normalem]{ulem}
\usepackage{makecell}
\usepackage{xcolor}



\doublespacing 
\linenumbers

# Introduction
Predictive approaches to heterogeneity of treatment effects (HTE) aim at the
development of models predicting either individualized effects or which of two
(or more) treatments is better for an individual [@Varadhan2013]. In prior work,
we divided such methods in three broader categories based on the reference class
used for defining patient similarity when making individualized predictions or
recommendations [@Rekkas2020]. Risk-modeling approaches use prediction of
baseline risk as the reference; treatment effect modeling approaches also model
treatment-covariate interactions, in addition to risk factors; optimal treatment
regime approaches focus on developing treatment assignment rules and rely
heavily on modeling treatment effect modifiers.

Risk-modeling approaches to predictive HTE analyses provide a viable option in
the absence of well-established treatment effect modifier [@Kent2019;
@PathEnE]. In simulations, modeling treatment-covariate interactions, often led
to miscalibrated predictions of absolute benefit, contrary to risk-based
methods, despite their weaker discrimination of benefit in the presence of true
effect modifiers [@vanKlaveren2019]. Most often, risk-modeling approaches are
carried out in two steps: first a risk prediction model is developed externally
or internally on the entire RCT population, “blinded” to treatment; then the RCT
population is stratified using this prediction model to evaluate risk-based
treatment effect variation [@Kent2010]. This approach identified substantial
absolute treatment effect differences between low-risk and high-risk patients in
a re-analysis of 32 large trials [@Kent2016]. However, even though estimates at
the risk subgroup level may be accurate, these estimates may not apply to
individual patients.

In the current simulation study, we aim to summarize and compare different
risk-based models for predicting treatment effects. We simulate different
relations between baseline risk and treatment effects and also consider
potential harms of treatment. We illustrate the different models by a case study
of predicting individualized effects of treatment for acute myocardial
infarction (MI) in a large RCT.


# Methods

## Notation

We observe RCT data $(Z, X, Y)$, where for each patient $Z_i= 0, 1$ is the
treatment status, $Y_i = 0, 1$ is the observed outcome and $X_i$ is a set of
measured covariates. Let $\{Y_i(z), z=0, 1\}$ denote the unobservable potential
outcomes. We observe $Y_i = Z_iY_i(1) + (1 - Z_i)Y_i(0)$. We are interested in
predicting the conditional average treatment effect (CATE), 
$$\tau(x) = E\{Y(0) - Y(1)|X=x\}$$ 
Assuming that $(Z, X, Y)$ is a random sample from the target population and that
$\big(Y(0), Y(1)\big)\indep Z|X$, as we are in the RCT setting, we can predict
CATE from
\begin{align*}
\tau(x) &= E\{Y(0)\given X=x\}-E\{Y(1)\given X=x\}\\
&=E\{Y\given X=x, Z=0\}-E\{Y\given X=x, Z=1\}
\end{align*}

## Simulation scenarios

We simulated a typical RCT, comparing equally-sized treatment and control arms
in terms of a binary outcome. For each patient we generated 8 baseline
covariates $x_1,\dots,x_4\sim N(0, 1)$ and $x_5,\dots,x_8\sim
B(1,0.2)$. Outcomes in the control arm were generated from Bernoulli variables
with true probabilities following a logistic regression model including all
baseline covariates, i.e.
$P(Y(0)=1\given X=x) = \text{expit}(lp_0) = e^{lp_0}/(1+e^{lp_0})$,
with $lp_0=lp_0(x)=x^t\beta$.
In the base scenarios coefficient values $\beta$ were
such, that the AUC of the logistic regression model was 0.75 and the event rate
in the control arm was $20\%$.

Outcomes in the treatment arm were first generated using 3 simple scenarios:
absent (OR = 1), moderate (OR = 0.8) or strong (OR = 0.5) constant relative
treatment effect. We then introduced linear, quadratic and non-monotonic
deviations from constant treatment effects using:
$$lp_1 = \gamma_2(lp_0-c)^2 + \gamma_1(lp_0-c) + \gamma_0, $$
where $lp_1$ is the true linear predictor in the treatment arm, so that
$P(Y(1)=1\given X=x) = \text{expit}(lp_1)$.
Finally, we incorporated constant absolute harms for all treated patients, such
that
$P(Y(1)=1|X=x) = \text{expit}(lp_1) + \text{harm}$.

The sample size for the base scenarios was set to 4,250 (80\% power for the
detection of a marginal OR of 0.8 with the standard alpha of 5\%). We evaluated
the effect of smaller or larger sample sizes of 1,063 and 17,000,
respectively. We also evaluated the effect of risk model discriminative ability,
adjusting the baseline covariate coefficients, such that the AUC of the
regression model in the control arm was 0.65 and 0.85, respectively.

These settings resulted in a simulation study of 648 scenarios covering the
observed HTE in 32 large trials as well as many other potential variations of
risk-based treatment effect (Supplement, Sections 2 and 3) [@Kent2016].
 
## Individualized risk-based benefit predictions

In each simulation run we internally developed a prediction model on the entire
population, using a logistic regression with main effects for all baseline
covariates and treatment assignment. Individual risk predictions were derived by
setting treatment assignment to 0. Another approach would be to derive the
prediction model solely on the control patients; however, it has been shown to
lead to biased benefit predictions [@vanKlaveren2019; @Burke2014; @Abadie2018].

A *stratified HTE method* has been suggested as an alternative to traditional
subgroup analyses [@Kent2019; @PathEnE]. Patients are stratified into
equally-sized risk strata—in this case based on risk quartiles. Absolute
treatment effects within risk strata are estimated by the difference in event
rate between control and treatment arm patients. We considered this approach as
a reference, expecting it to perform worse than the other candidates, as its
objective is to provide an illustration of HTE rather than to optimize
individualized benefit predictions.

Second, we considered a model which assumes *constant relative treatment effect*
(constant odds ratio). Hence, absolute benefit is predicted from
$\tau(x;\hat{\beta}) = \text{expit}(\hat{lp}_0) - \text{expit}(\hat{lp}_0+\delta_0)$, where
$\delta_0$ is the log of the assumed constant odds ratio and
$\hat{lp}_0 = \hat{lp}_0(x;\hat{\beta}) = x^t\hat{\beta}$
the linear predictor of the estimated baseline risk model.

Third, we considered a logistic regression model including treatment, the
prognostic index, and their linear interaction. Absolute benefit is then
estimated from
$\tau(x;\hat{\beta}) = \text{expit}(\delta_0+\delta_1\hat{lp}_0) - \text{expit}(\delta_0+\delta_2+(\delta_1+\delta_3)\hat{lp}_0)$
We will refer to this method as the *linear interaction* approach.

Fourth, we used *restricted cubic splines* (RCS) to relax the linearity
assumption on the effect of the linear predictor [@Harrell1988]. We considered
splines with 3 (RCS-3), 4 (RCS-4) and 5 (RCS-5) knots to compare models with
different levels of flexibility.

Finally, we considered an adaptive approach using Akaike’s Information Criterion
(AIC) for model selection. More specifically, we ranked the constant relative
treatment effect model, the linear interaction model, and the RCS models with 3,
4, and 5 knots based on their AIC and selected the one with the lowest
value. The extra degrees of freedom were 1 (linear interaction), 2, 3 and 4 (RCS
models) for these increasingly complex interactions with the treatment effect.

## Evaluation metrics
We evaluated the predictive accuracy of the considered methods by the root mean
squared error (RMSE):

$$\text{RMSE}=\sqrt{\frac{1}{n}\sum_{i=1}^n\big(\tau(x_i) - \hat{\tau}(x_i)\big)^2}$$

We compared the discriminative ability of the methods under study using
c-for-benefit and the integrated calibration index (ICI) for
benefit (Supplement, Section 6) [@vanKlaveren2018].

For each scenario we performed 500 replications, within which all the considered
models were fitted. We simulated a super-population of size 500,000 for each
scenario within which we calculated RMSE and discrimination and calibration for
benefit of all the models in each replication.

## Empirical illustration



We demonstrated the different methods using 30,510 patients with acute
myocardial infarction (MI) included in the GUSTO-I trial.  10,348 patients were randomized to tissue
plasminogen activator (tPA) treatment and 20,162 were randomized to streptokinase. The outcome of interest
was 30-day mortality (total of 2,128 events), recorded for all
patients. In line with previous analyses [@Califf1997; @Steyerberg2000], we
fitted a logistic regression model with 6 baseline covariates, i.e. age, Killip
class, systolic blood pressure, heart rate, an indicator of previous MI, and the
location of MI, to predict 30-day mortality risk (Supplement, Section 8).

# Results

## Simulations





The constant treatment effect approach outperformed other approaches in the base
case scenario (N = 4,250; OR = 0.8; AUC= 0.75; no absolute treatment harm)
with a true constant treatment effect (median RMSE: constant treatment effect 
0.009;
linear interaction 0.014;
RCS-3 0.018). 
The linear interaction model was optimal under true linear deviations 
(median RMSE: constant treatment effect 
0.027;
linear interaction 0.015;
RCS-3 0.018; Figure \ref{fig:rmsebase} panels A-C)
and even in the presence of true quadratic deviations
(median RMSE: constant treatment effect 
0.057;
linear interaction 0.020;
RCS-3 0.021; Figure \ref{fig:rmsebase} panels A-C)
from a constant relative treatment effect. With non-monotonic deviations, RCS-3
slightly outperformed the linear interaction model
(Median RMSE: linear interaction 0.019;
RCS-3 0.018; Figure \ref{fig:rmsebase} panel D).
With strong treatment-related harms the results were very similar in most
scenarios (Figure \ref{fig:rmsebase} panels A-C). Under non-monotonic deviations
the optimal performance of RCS-3 was more pronounced
(Median RMSE: linear interaction 0.024;
RCS-3 0.019; Figure \ref{fig:rmsebase} panel D).
A stronger average treatment effect (OR=0.5) led to larger absolute benefit
predictions and consequently to larger RMSE for all approaches, but the relative
differences between different approaches were similar to the base case scenario
(Supplement, Figure S10).

<div class="figure">
<img src="index_files/figure-html/rmsebase-1.png" alt="RMSE of the considered methods across 500 replications calculated from a simulated super-population of size 500,000. The scenario with true constant relative treatment effect (panel A) had a true prediction AUC of 0.75 and sample size of 4250. The RMSE is also presented for strong linear (panel B), strong quadratic (panel C), and non-monotonic (panel D) from constant relative treatment effects. Panels on the right side present the true relations between baseline risk (x-axis) and absolute treatment benefit (y-axis). The 2.5, 25, 50, 75, and 97.5 percentiles of the risk distribution are expressed by the boxplot on the top. The 2.5, 25, 50, 75, and 97.5 percentiles of the true benefit distributions are expressed by the boxplots on the side of the right-handside panel." width="100%" />
<p class="caption">(\#fig:rmsebase)RMSE of the considered methods across 500 replications calculated from a simulated super-population of size 500,000. The scenario with true constant relative treatment effect (panel A) had a true prediction AUC of 0.75 and sample size of 4250. The RMSE is also presented for strong linear (panel B), strong quadratic (panel C), and non-monotonic (panel D) from constant relative treatment effects. Panels on the right side present the true relations between baseline risk (x-axis) and absolute treatment benefit (y-axis). The 2.5, 25, 50, 75, and 97.5 percentiles of the risk distribution are expressed by the boxplot on the top. The 2.5, 25, 50, 75, and 97.5 percentiles of the true benefit distributions are expressed by the boxplots on the side of the right-handside panel.</p>
</div>

The adaptive approach had limited loss of performance in terms of the median
RMSE to the best-performing method in each scenario. However, compared to the
best-performing approach, its RMSE was more variable in scenarios with linear
and non-monotonic deviations, especially when also including moderate or strong
treatment-related harms. On closer inspection, we found that this behavior was
caused by selecting the constant treatment effect model in a substantial
proportion of the replications (Supplement, Figure S3).



Increasing the sample size to 17,000 favored RCS-3 the most. The difference in
performance with the linear interaction approach was more limited in settings
with a constant treatment effect 
(Median RMSE: linear interaction 0.007;
RCS-3 0.009) and with a true linear interaction
(Median RMSE: linear interaction 0.008;
RCS-3 0.009).
and more emphasized in settings with strong quadratic deviations 
(Median RMSE: linear interaction 0.013;
RCS-3 0.011) and non-monotonic deviations
(Median RMSE: linear interaction 0.014;
RCS-3 0.010).
Due to the large sample size, the RMSE of the adaptive approach was even more
similar to the best-performing method, and the constant relative treatment
effect model was less often wrongly selected (Supplement, Figure S4).

<div class="figure">
<img src="index_files/figure-html/rmsesamplesize-1.png" alt="RMSE of the considered methods across 500 replications calculated in simulated samples of size 17,000 rather than 4,250 in Figure \ref{fig:rmsebase}. RMSE was calculated on a super-population of size 500,000" width="100%" />
<p class="caption">(\#fig:rmsesamplesize)RMSE of the considered methods across 500 replications calculated in simulated samples of size 17,000 rather than 4,250 in Figure \ref{fig:rmsebase}. RMSE was calculated on a super-population of size 500,000</p>
</div>





Similarly, when we increased the AUC of the true prediction model to 0.85 (OR =
0.8 and N = 4,250), RCS-3 had the lowest RMSE in the case of strong quadratic or
non-monotonic deviations and very comparable performance to the – optimal –
linear interaction model in the case of strong linear deviations (median RMSE of
0.016 for RCS-3 compared to 
0.014 for the linear interaction
model). Similar to the base case scenario the adaptive approach wrongly selected
the constant treatment effect model
(23\%
and
25\%
of the replications in the
strong linear and non-monotonic deviation scenarios without treatment-related
harms, respectively), leading to increased variability of the RMSE (Supplement,
Figure S5).

<div class="figure">
<img src="index_files/figure-html/rmseauc-1.png" alt="RMSE of the considered methods across 500 replications calculated in simulated samples 4,250. True prediction AUC of 0.85. RMSE was calculated on a super-population of size 500,000" width="100%" />
<p class="caption">(\#fig:rmseauc)RMSE of the considered methods across 500 replications calculated in simulated samples 4,250. True prediction AUC of 0.85. RMSE was calculated on a super-population of size 500,000</p>
</div>


    
With a true constant relative treatment effect, discrimination for benefit was
only slightly lower for the linear interaction model, but substantially lower
for the non-linear RCS approaches (Figure \ref{fig:discrimination}; panel
A). With strong linear or quadratic deviations from a constant relative
treatment effect, all methods discriminated quite similarly (Figure
\ref{fig:discrimination}; panels B-C). With non-monotonic deviations, the
constant effect model had much lower discriminative ability compared to all
other methods
(median AUC of 0.500 for the constant effects model,
0.528
for the linear interaction model and
0.530
Figure \ref{fig:discrimination}; panel D).
The adaptive approach was unstable in terms of discrimination for benefit,
especially with treatment-related harms. With increasing number of RCS knots, we
observed decreasing median values and increasing variability of the
c-for-benefit in all scenarios. When we increased the sample size to 17,000 we
observed similar trends, however the performance of all methods was more stable
(Supplement, Figure S6). Finally, when we increased the true prediction AUC to
0.85 the adaptive approach was, again, more conservative, especially with
non-monotonic deviations and null or moderate treatment-related harms
(Supplement, Figure S5).

<div class="figure">
<img src="index_files/figure-html/discrimination-1.png" alt="Discrimination for benefit of the considered methods across 500 replications calculated in a simulated samples of size 4,250. True prediction AUC of 0.75." width="100%" />
<p class="caption">(\#fig:discrimination)Discrimination for benefit of the considered methods across 500 replications calculated in a simulated samples of size 4,250. True prediction AUC of 0.75.</p>
</div>

In terms of calibration for benefit, the constant effects model outperformed all
other models in the scenario with true constant treatment effects, but was
miscalibrated for all deviation scenarios (Figure \ref{fig:calibration}). The
linear interaction model showed best or close to best calibration across all
scenarios and was only outperformed by RCS-3 in the case of non-monotonic
deviations and treatment-related harms (Figure \ref{fig:calibration}; panel
D). The adaptive approach was worse calibrated under strong linear and
non-monotonic deviations compared to the linear interaction model and
RCS-3. When we increased the sample size to 17,000 (Supplement, Figure S6) or
the true prediction AUC to 0.85 (Supplement, Figure S7), RCS-3 was somewhat
better calibrated than the linear interaction model with strong quadratic
deviations.

<div class="figure">
<img src="index_files/figure-html/calibration-1.png" alt="Calibration for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.75 and sample size of 4,250." width="100%" />
<p class="caption">(\#fig:calibration)Calibration for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.75 and sample size of 4,250.</p>
</div>




The results from all individual scenarios can be explored online at
[https://arekkas.shinyapps.io/simulation_viewer/](https://arekkas.shinyapps.io/simulation_viewer/). Additionally,
all the code for the simulations can be found at
[https://github.com/rekkasa/arekkas_HteSimulation_XXXX_2021](https://github.com/rekkasa/arekkas_HteSimulation_XXXX_2021)


## Empirical illustration




We used the derived prognostic index to fit a constant treatment effect, a
linear interaction and an RCS-3 model individualizing absolute benefit
predictions. Following our simulation results, RCS-4 and RCS-5 models were
excluded. Finally, an adaptive approach with the 3 candidate models was applied.

All considered methods provided similar fits, predicting increasing benefits for
patients with higher baseline risk predictions, and followed the evolution of
the stratified estimates closely (Figure \ref{fig:gusto}). The constant
treatment effect model had somewhat lower AIC compared to the linear interaction
model (AIC: 
9,336 versus 
9,342),
equal cross-validated discrimination
(c-for-benefit:
0.525),
and slightly better cross-validated calibration
(ICI-for benefit:
0.010 versus 
0.012).
In conclusion, although the sample size (30,510 patients; 
2,128 events) allowed for flexible modeling approaches, a 
simpler constant treatment effect model is adequate for predicting absolute
30-day mortality benefits of treatment with tPA in patients with acute MI.

<div class="figure">
<img src="index_files/figure-html/gusto-1.png" alt="Individualized absolute benefit predictions based on baseline risk when using a constant treatment effect approach, a linear interaction approach and RCS smoothing using 3 knots. Risk stratified estimates of absolute benefit are presented within quartiles of baseline risk as reference." width="100%" />
<p class="caption">(\#fig:gusto)Individualized absolute benefit predictions based on baseline risk when using a constant treatment effect approach, a linear interaction approach and RCS smoothing using 3 knots. Risk stratified estimates of absolute benefit are presented within quartiles of baseline risk as reference.</p>
</div>

# Discussion

The linear interaction and the RCS-3 models displayed very good performance
under many of the considered simulation scenarios. The linear interaction model
was optimal in cases with moderate sample sizes (4.250 patients; ~785 events)
and moderately performing baseline risk prediction models, that is, it had lower
RMSE, was better calibrated for benefit and had better discrimination for
benefit, even in scenarios with strong quadratic deviations. In scenarios with
true non-monotonic deviations, the linear interaction model was outperformed by
RCS-3, especially in the presence of treatment-related harms. Increasing the
sample size or the prediction model’s discriminative ability favored RCS-3,
especially in scenarios with strong non-linear deviations from a constant
treatment effect.

Our simulation results clearly express the trade-off between the advantages of
flexibly modeling the relationship between baseline risk and treatment effect
and the disadvantages of overfitting this relationship to the sample at hand. With
infinite sample size, the more flexible approach (here RCS) will be optimal, but
in practice, with limited sample size, parsimonious models may be
preferable. Even with the substantial sample size of our base case scenario, the
(less flexible) linear interaction model performed better than the (more
flexible) RCS approach for most simulation settings. The even less flexible
constant treatment effect model, however, was only optimal when the treatment
effect was truly constant. Moreover, the assumption of a constant treatment
effect may often be too strong [@Rothwell1995; @Kent2016].  For example, infants
at lower risk of bronchopulmonary dysplasia benefit relatively more from vitamin
A therapy than infants at higher risk [@Rysavy2021]; higher risk prediabetic
patients benefit relatively more from metformin than lower risk patients
[@Sussman2015]. Hence, a linear interaction between baseline risk and the effect
of treatment may be the most sensible approach with moderate sample sizes.

RCS-4 and RCS-5 were too flexible in all considered scenarios, as indicated by
higher RMSE, increased variability of discrimination for benefit and worse
calibration of benefit predictions. Even with larger sample sizes and strong
quadratic or non-monotonic deviations, these more flexible methods did not
outperform the simpler RCS-3 approach. Higher flexibility may only be helpful
under more extreme patterns of HTE compared to the quadratic deviations
considered here. Considering interactions in RCS-3 models as the most complex
approach often may be reasonable.

Increasing the discriminative ability of the risk model reduced RMSE for all
methods. Higher discrimination translates in higher variability of predicted
risks, which, in turn, allows the considered methods to better capture absolute
treatment benefits. As a consequence, better risk discrimination also led to
higher discrimination between those with low or high benefit (as reflected in
values of c-for-benefit).

The adaptive approach had adequate median performance, following the “true”
model in most scenarios. With smaller sample sizes it tended to miss the
treatment-baseline risk interaction and selected simpler models (Supplement
Section 4). This conservative behavior resulted in increased RMSE variability in
these scenarios, especially with true strong linear or non-monotonic
deviations. Therefore, with smaller sample sizes the simpler linear interaction
model may be a safer choice for predicting absolute benefits, especially in the
presence of any suspected treatment-related harms.

One limitation is that we assumed treatment benefit to be a function of baseline
risk in the majority of the simulation scenarios. We attempted to expand our
scenarios by considering constant moderate and strong treatment-related harms,
applied on the absolute scale, in line with previous work [@Glasziou1995]. In a
limited set of scenarios with true interactions between treatment assignment and
covariates, our conclusions remained unchanged (Supplement, Section 7). Even
though the average error rates increased for all the considered methods, due to
the miss-specification of the outcome model, the linear interaction model had
the lowest error rates. RCS-3 had very comparable performance. The constant
treatment effect model was often biased, especially with moderate or strong
treatment-related harms. Future simulation studies could explore the effect of
more extensive deviations from risk-based treatment effects.

We only focused on risk-based methods, using baseline risk as a reference in a
two-stage approach to individualizing benefit predictions. However, there is a
plethora of different methods, ranging from treatment effect modeling to
tree-based approaches available in more recent literature [@Athey2019; @Lu2018;
@Wager2018; @powers2018some]. Many of these methods rely on incorporating
treatment-covariate interactions when predicting benefit. An important caveat of
such approaches is their sensitivity to overfitting, which may exaggerate the
magnitude of predicted benefits. In a wide range of simulation settings, a
simpler risk modeling approach was consistently better calibrated for benefit
compared to more complex treatment effect modelling approaches
[@vanKlaveren2019]. Similarly, when SYNTAX score II, a model developed for
identifying patients with complex coronary artery disease that benefit more from
percutaneous coronary intervention or from coronary artery bypass grafting was
redeveloped using fewer treatment-covariate interactions had better external
performance compared to its predecessor [@farooq2013anatomical;
@takahashi2020redevelopment]. However, whether this remains the case in a range
of empirical settings still needs to be explored.

In conclusion, the linear interaction approach is a viable option with moderate
sample sizes and/or moderately performing risk prediction models, assuming a
non-constant relative treatment effect plausible. RCS-3 is a better option with
more abundant sample size and when non-monotonic deviations from a constant
relative treatment effect and/or substantial treatment-related harms are
anticipated. Increasing the complexity of the RCS models by increasing the
number of knots does not improve benefit prediction. Using AIC for model
selection is attractive with larger sample size.
