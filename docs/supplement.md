# Supplement




## Notation
We observe RCT data $(Z, X, Y)$, where for each patient $Z_i= 0, 1$ is the
treatment status, $Y_i = 0, 1$ is the observed outcome and $X_i$ is a set of
covariates measured. Let $\{Y_i(z), z=0, 1\}$ denote the unobservable potential
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

Based on an estimate of baseline risk
$$
E\{Y\given X=x, Z=0\}=g\big(\hat{lp}(x)\big)
$$
with $\hat{u}=\hat{lp}(x)=x^t\hat{\beta}$ the linear predictor and $g$ the link function,
we predict CATE from
$$
\hat{\tau}(x) = g\big(f(\hat{u}, 0)\big) - g\big(f(\hat{u}, 1)\big)
$$
where $f(u,z)$ describes interactions of the baseline risk linear predictor with
treatment. 

## Simulation settings
For all patients we observe covariates $X_1,\dots,X_8$, of which $4$ are
continuous and $4$ are binary. More specifically,

\begin{equation*}
X_1,\dots,X_4 \sim N(0, 1)
\end{equation*}
\begin{equation*}
X_5,\dots,X_8 \sim B(1, 0.2)
\end{equation*}

We first, generate the binary outcomes $Y$ for the untreated patients ($Z=0$),
based on

\begin{equation} 
P(Y=1\given X=x, Z=0) = g(\beta_0 + \beta_1x_1+\dots+\beta_8x_8) = g(lp_0),
(\#eq:p0)
\end{equation}

where $$g(x) = \frac{e^x}{1+e^x}$$

For treated patients, outcomes are generated from:

\begin{equation}
P(Y = 1\given X=x, Z=1) = g(lp_1)
(\#eq:p1)
\end{equation}


where $$lp_1 = \gamma_2(lp_0-c)^2+\gamma_1(lp_0-c)+\gamma_0$$

## Base-case scenario
The base-case scenario assumes a constant odds ratio of $0.8$ in favor of
treatment. The simulated datasets are of size $n=4250$, where treatment is
allocated at random using a 50/50 split (80% power for the detection of an
unadjusted OR of 0.8, assuming an event rate of 20% in the untreated
arm). Outcome incidence in the untreated population is set at $20\%$. For the
development of the prediction model we use the model defined in \@ref(eq:p0)
including a constant treatment effect. When doing predictions, $Z$ is set to
$0$. The value of the true $\beta$ is such that the above prediction model
has an AUC of $0.75$.


The previously defined targets are achieved when $\beta=(-2.08,
0.49,\dots,0.49)^t$. For the derivations in the treatment arm we use
$\gamma=(\log(0.8), 1, 0)^t$.

## Deviations from base-case
We deviate from the base-case scenario in two ways. First, we alter the overall
target settings of sample size, overall treatment effect and prediction model
AUC. In a second stage, we consider settings that violate the assumption of a
constant relative treatment effect, using a model-based approach.

For the first part, we consider:

* Sample size:
  + $n=1064$
  + $n=17000$
* Overall treatment effect:
  + $OR=0.5$
  + $OR=1$
* Prediction performance:
  + $AUC=0.65$
  + $AUC=0.85$
  
We set the true risk model coefficients to be
$\bm{\beta} = \big(-1.63,0.26,\dots,0.26\big)^t$ for $AUC=0.65$ and $\bm{\beta} = \big(-2.7,0.82,\dots,0.82\big)^t$ 
for $AUC=0.85$. In both cases, $\beta_0$ is selected so that an event rate of
$20\%$ is maintained in the control arm.

For the second part linear, quadratic and non-monotonic deviations from the
assumption of constant relative effect are considered. We also consider
different intensity levels of these deviations. Finally, constant absolute
treatment-related harms are introduced, i.e. positive 
($0.25\times\text{true average benefit}$),
strong positive ($0.50\times\text{true average benefit}$) and negative
($-0.25\times\text{true average benefit}$; i.e. constant absolute
treatment-related benefit). In case of true absent treatment effects,
treatment-related harms are set to $1\%, 2\%$ and $-1\%$ for positive, strong
positive and negative setting, respectively. The settings for these deviations
are defined in Table \@ref(tab:tab1).

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; "><table class="table" style="font-size: 9px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:tab1)Scenario settings of the entire simulation study.</caption>
 <thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="6"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Analysis ID</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="9"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Baseline risk</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="4"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">True treatment effect</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Benefit</div></th>
</tr>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Scenario </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Base </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Type </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> N </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AUC </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Treatment-related harm </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b0 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b1 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b2 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b3 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b4 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b5 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b6 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b7 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b8 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g0 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g1 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g2 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> c </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Before harms </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> After harms </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 56 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.060 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.080 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.070 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 96 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.250 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 101 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 104 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.220 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 111 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 112 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 114 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 117 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 126 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 127 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 129 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 131 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 132 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 133 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 135 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 136 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.810 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 139 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.770 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 141 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 142 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 143 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 144 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.710 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 145 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 146 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 147 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 148 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 149 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 152 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 153 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 154 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 156 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 157 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 159 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 161 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 162 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 163 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 164 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 166 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 167 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 168 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 169 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 171 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 172 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.220 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 173 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 174 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 176 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.160 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 177 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 178 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 179 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -3.950 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 181 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 182 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 183 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 184 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 185 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 186 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 187 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 188 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 189 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 190 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 191 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 192 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 193 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 194 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 195 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 196 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 197 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 198 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 199 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 200 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 201 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 203 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 204 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 205 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 206 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 207 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 208 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 2.490 </td>
   <td style="text-align:right;"> 4.210 </td>
   <td style="text-align:right;"> 0.540 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 209 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 210 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 211 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 212 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 2.150 </td>
   <td style="text-align:right;"> 3.320 </td>
   <td style="text-align:right;"> 0.380 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 213 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 214 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 216 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 1.740 </td>
   <td style="text-align:right;"> 4.100 </td>
   <td style="text-align:right;"> 0.550 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 217 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 218 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 219 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 220 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 221 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 222 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 223 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 224 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 225 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 226 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 227 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 228 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 229 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 230 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 231 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 232 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 233 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 234 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 235 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 236 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 237 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 238 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 239 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 240 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 241 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 242 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 243 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 244 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 245 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 246 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 247 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 248 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 249 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 250 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 251 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 252 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.223 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 253 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 254 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 255 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 256 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 257 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 258 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 259 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 260 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 261 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 262 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 263 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 264 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 265 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 266 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 267 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 268 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 269 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 270 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 271 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 272 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 273 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 274 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 275 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 276 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 277 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 278 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 279 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 280 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.290 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 281 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 282 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 283 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 284 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.300 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 285 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 286 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 287 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 288 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.280 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 289 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 290 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 291 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 292 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 293 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 294 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 295 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 296 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 297 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 298 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 299 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 300 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 301 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 302 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 303 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 304 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 305 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 306 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 307 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 308 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 309 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 310 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 311 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 312 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 313 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 314 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 315 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 316 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.460 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 317 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 318 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 319 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 320 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.500 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 321 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 322 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 323 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 324 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.410 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 325 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 326 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 327 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 328 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 329 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 330 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 331 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 332 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 333 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 334 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 335 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 336 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 337 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 338 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 339 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 340 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 341 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 342 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 343 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 344 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 345 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 346 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 347 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 348 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 349 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 350 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 351 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 352 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.020 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 353 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 354 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 355 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 356 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.990 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 357 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 358 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 359 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.910 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 361 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 362 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 363 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 364 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 365 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 366 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 367 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 368 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 369 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 370 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 371 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 372 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 373 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 374 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 375 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 376 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 377 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 378 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 379 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 380 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 381 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 382 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 383 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 384 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 385 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 386 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 387 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.420 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 389 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 390 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 391 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 392 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.380 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 393 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 394 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 395 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 396 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.130 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 397 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 398 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 399 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 400 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 401 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 402 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 403 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 404 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 405 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 406 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 407 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 408 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 409 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 410 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 411 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 412 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 413 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 414 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 415 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 416 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 417 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 418 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 419 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 420 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 421 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.029 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 422 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.022 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 423 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 424 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.173 </td>
   <td style="text-align:right;"> 1.560 </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.029 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 425 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 426 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.025 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 427 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.016 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 428 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.481 </td>
   <td style="text-align:right;"> 1.783 </td>
   <td style="text-align:right;"> 0.137 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 429 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.024 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 430 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.018 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 431 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 432 </td>
   <td style="text-align:right;"> moderate </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.085 </td>
   <td style="text-align:right;"> 1.354 </td>
   <td style="text-align:right;"> 0.074 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.024 </td>
   <td style="text-align:right;"> 0.030 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 433 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 434 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 435 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 436 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 437 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 438 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 439 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 440 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 441 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 442 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 443 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 444 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 445 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 446 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 447 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 448 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 449 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 450 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 451 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 452 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 453 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 454 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 455 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 456 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 457 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 458 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 459 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 460 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 461 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 462 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 463 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 464 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 465 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 466 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 467 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 468 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> constant </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.693 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 469 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 470 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 471 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 472 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 473 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 474 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 475 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 476 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 477 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 478 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 479 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 480 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 481 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 482 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 483 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 484 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 485 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 486 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 487 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 488 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 489 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 490 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 491 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 492 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 493 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 494 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 495 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 496 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.750 </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 497 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 498 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 499 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 500 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.770 </td>
   <td style="text-align:right;"> 0.934 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 501 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 502 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 503 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 504 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.730 </td>
   <td style="text-align:right;"> 0.930 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 505 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 506 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 507 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 508 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 509 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 510 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 511 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 512 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 513 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 514 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 515 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 516 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 517 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 518 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 519 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 520 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 521 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 522 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 523 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 524 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 525 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 526 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 527 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 528 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 529 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 530 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 531 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 532 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.900 </td>
   <td style="text-align:right;"> 0.796 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 533 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 534 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 535 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 536 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -0.960 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 537 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 538 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 539 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 540 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> linear-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.840 </td>
   <td style="text-align:right;"> 0.785 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 541 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 542 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 543 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 544 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 545 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 546 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 547 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 548 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 549 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 550 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 551 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 552 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 553 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 554 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 555 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 556 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 557 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 558 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 559 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 560 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 561 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 562 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 563 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 564 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 565 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 566 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 567 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 568 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -5.480 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.013 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 569 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 570 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 571 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 572 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -5.460 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 573 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 574 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 575 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 576 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-moderate </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -5.350 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.016 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 577 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 578 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 579 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 580 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 581 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 582 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 583 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 584 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 585 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 586 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 587 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 588 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 589 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 590 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 591 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 592 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 593 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 594 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 595 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 596 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 597 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 598 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 599 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 600 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 601 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 602 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 603 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 604 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -4.860 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.052 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 605 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 606 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 607 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 608 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> -4.840 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 609 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 610 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 611 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 612 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> quadratic-high </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -4.510 </td>
   <td style="text-align:right;"> 1.000 </td>
   <td style="text-align:right;"> -0.059 </td>
   <td style="text-align:right;"> -5 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 613 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 614 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 615 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 616 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 617 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 618 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 619 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 620 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 621 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 622 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 623 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 624 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 625 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 626 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 627 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 628 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 629 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 630 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 631 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 632 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 633 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 634 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 635 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 636 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 1,063 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 637 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.079 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 638 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.059 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 639 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.040 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 640 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.084 </td>
   <td style="text-align:right;"> 2.035 </td>
   <td style="text-align:right;"> 0.210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.079 </td>
   <td style="text-align:right;"> 0.099 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 641 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.089 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 642 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.067 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 643 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.044 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 644 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.65 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -1.63 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.786 </td>
   <td style="text-align:right;"> 2.762 </td>
   <td style="text-align:right;"> 0.321 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.089 </td>
   <td style="text-align:right;"> 0.111 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 645 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 646 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.052 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 647 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 648 </td>
   <td style="text-align:right;"> high </td>
   <td style="text-align:right;"> non-monotonic </td>
   <td style="text-align:right;"> 17,000 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.70 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> -0.621 </td>
   <td style="text-align:right;"> 1.566 </td>
   <td style="text-align:right;"> 0.138 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.069 </td>
   <td style="text-align:right;"> 0.086 </td>
  </tr>
</tbody>
</table></div>

\newpage
## Plausible scenario settings

In this section we present specific scenarios from our simulation settings in
which evolution of benefit followed similar patterns to [@Kent2016]. In this
case patients were stratified into risk quarters based on their true baseline
risk. Within each risk quarter we constructed boxplots of true benefit.


## Approaches to individualize benefit predictions

### Risk modeling
Merging treatment arms, we develop prediction models including a constant relative treatment effect:

\begin{equation}
P(Y=1\given X=x,Z=z) = g(x^t\beta + \gamma z)
(\#eq:risk)
\end{equation}

We derive baseline risk predictions for patients by setting $Z=0$ in
\@ref(eq:risk). All methods for individualizing benefit predictions are 2-stage
methods, that start by fitting a model for predicting baseline risk. The
estimated linear predictor of this model is

\begin{equation*}
\hat{lp} = lp(x;\hat{\beta}) = x^t\hat{\beta}
\end{equation*}

### Risk stratification
Derive a prediction model using the same approach as above and divide the
population in equally sized risk-based subgroups. Estimate subgroup-specific
absolute benefit from the observed absolute differences. Subject-specific
benefit predictions are made by attributing to individuals their corresponding
subgroup-specific estimate.

### Constant treatment effect
Assuming a constant relative treatment effect, fit the adjusted model in
\@ref(eq:risk). Then, predict absolute benefit using 

\begin{equation}
\hat{\tau}(x;\hat{\beta},\hat{\gamma})=g(f(\hat{lp}, 0)) - g(f(\hat{lp},1)), 
(\#eq:main)
\end{equation}

where $f(\hat{lp}, z) = \hat{lp}+\hat{\gamma}z$, with $\hat{\gamma}$ the
estimated relative treatment effect (log odds ratio).

### Linear interaction
We relax the assumption of a constant relative treatment effect in
\@ref(eq:main) by setting

$$ f(\hat{lp}, z) = \gamma_0+\gamma_1z+\gamma_2\hat{lp}+\gamma_3z\hat{lp} $$

### Restricted cubic splines
Finally, we drop the linearity assumption and predict absolute benefit using
smoothing with restricted cubic splines with $k=3, 4$ and $5$ knots. More
specifically, we set:

$$ f(\hat{lp}, z) = \gamma_0 + \gamma_1z+zs(\hat{lp}) $$
where
$$s(x)=\alpha_0+\alpha_1h_1(x)+\alpha_2h_2(x)+\dots+\alpha_{k-1}h_{k-1}(x)$$
with $h_1(x)=x$ and for $j=2,\dots,k-2$
$$h_{j+1}(x)= (x-t_j)^3-(x-t_{k-1})_+^3 \frac{t_k-t_j}{t_k-t_{k-1}}+(x-t_k)^3_+\frac{t_{k-1}-t_j}{t_k-t_{k-1}}$$
where 
$t_1,\dots,t_k$ are the selected knots [@harrell2017regression]. 



\newpage
## Adaptive model selection frequencies

<div class="figure">
<img src="supplement_files/figure-html/adaptiveBase-1.png" alt="Model selection frequencies of the adaptive approach based on Akaike's Information Criterion across 500 replications. The scenario with the true constant relative treatment effect (first panel) had a true prediction AUC of 0.75 and sample size of 4,250. " width="100%" />
<p class="caption">(\#fig:adaptiveBase)Model selection frequencies of the adaptive approach based on Akaike's Information Criterion across 500 replications. The scenario with the true constant relative treatment effect (first panel) had a true prediction AUC of 0.75 and sample size of 4,250. </p>
</div>

<div class="figure">
<img src="supplement_files/figure-html/adaptiveSampleSize-1.png" alt="Model selection frequencies of the adaptive approach based on Akaike's Information Criterion across 500 replications. Sample size is 17,000 rather than 4,250 in Figure \ref{fig:adaptiveBase}" width="100%" />
<p class="caption">(\#fig:adaptiveSampleSize)Model selection frequencies of the adaptive approach based on Akaike's Information Criterion across 500 replications. Sample size is 17,000 rather than 4,250 in Figure \ref{fig:adaptiveBase}</p>
</div>

<div class="figure">
<img src="supplement_files/figure-html/adaptiveAuc-1.png" alt="Model selection frequencies of the adaptive approach based on Akaike's Information Criterion across 500 replications. AUC is 0.85 rather than 0.75 in Figure \ref{fig:adaptiveBase}" width="100%" />
<p class="caption">(\#fig:adaptiveAuc)Model selection frequencies of the adaptive approach based on Akaike's Information Criterion across 500 replications. AUC is 0.85 rather than 0.75 in Figure \ref{fig:adaptiveBase}</p>
</div>

\newpage
## Discrimination and calibration for benefit
The c-for-benefit represents the probability that from two randomly chosen
matched patient pairs with unequal observed benefit, the pair with greater
observed benefit also has a higher predicted benefit. To be able to calculate
observed benefit, patients in each treatment arm are ranked based on their
predicted benefit and then matched 1:1 across treatment arms. Observed treatment
benefit is defined as the difference of observed outcomes between the untreated
and the treated patient of each matched patient pair. Predicted benefit is
defined as the average of predicted benefit within each matched patient pair.

We evaluated calibration in a similar manner, using the integrated calibration
index (ICI) for benefit [@Austin2019]. The observed benefits are regressed on the
predicted benefits using a locally weighted scatterplot smoother (loess). The
ICI-for-benefit is the average absolute difference between predicted and smooth
observed benefit. Values closer to represent better calibration.

<div class="figure">
<img src="supplement_files/figure-html/discriminationSampleSize-1.png" alt="Discrimination for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.75 and sample size of 17,000" width="100%" />
<p class="caption">(\#fig:discriminationSampleSize)Discrimination for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.75 and sample size of 17,000</p>
</div>


<div class="figure">
<img src="supplement_files/figure-html/discriminationAuc-1.png" alt="Discrimination for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.85 and sample size of 4,250" width="100%" />
<p class="caption">(\#fig:discriminationAuc)Discrimination for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.85 and sample size of 4,250</p>
</div>

<div class="figure">
<img src="supplement_files/figure-html/calibrationSampleSize-1.png" alt="Calibration for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.75 and sample size of 17,000" width="100%" />
<p class="caption">(\#fig:calibrationSampleSize)Calibration for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.75 and sample size of 17,000</p>
</div>


<div class="figure">
<img src="supplement_files/figure-html/calibrationAuc-1.png" alt="Calibration for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.85 and sample size of 4,250" width="100%" />
<p class="caption">(\#fig:calibrationAuc)Calibration for benefit of the considered methods across 500 replications calculated in a simulated sample of size 500,000. True prediction AUC of 0.85 and sample size of 4,250</p>
</div>

\newpage
## Strong relative treatment effect

Here we present the root mean squared error of the considered methods using
strong constant relative treatment effect ($\text{OR}=0.5$) as the
reference. Again, the same sample size and prediction performance settings were
considered along with the same settings for linear, quadratic and non-monotonic
deviations from the base case scenario of constant relative treatment effects
are considered. All results can be found at
[https://arekkas.shinyapps.io/simulation_viewer/](https://arekkas.shinyapps.io/simulation_viewer/).

<div class="figure">
<img src="supplement_files/figure-html/rmseHighBase-1.png" alt="RMSE of the considered methods across 500 replications calculated in a simulated super-population of size 500,000. The scenario with true constant relative treatment effect (panel A) had a true prediction AUC of 0.75 and sample size of 4,250. The RMSE is also presented for strong linear (panel B), strong quadratic (panel C), and non-monotonic (panel D) deviations from constant relative treatment effects. Panels on the right side present the true relationship between baseline risk (x-axis) and absolute treatment benefit (y-axis). The 2.5, 25, 75 and 97.5 percentiles of the risk distribution are expressed in the boxplot." width="100%" />
<p class="caption">(\#fig:rmseHighBase)RMSE of the considered methods across 500 replications calculated in a simulated super-population of size 500,000. The scenario with true constant relative treatment effect (panel A) had a true prediction AUC of 0.75 and sample size of 4,250. The RMSE is also presented for strong linear (panel B), strong quadratic (panel C), and non-monotonic (panel D) deviations from constant relative treatment effects. Panels on the right side present the true relationship between baseline risk (x-axis) and absolute treatment benefit (y-axis). The 2.5, 25, 75 and 97.5 percentiles of the risk distribution are expressed in the boxplot.</p>
</div>

<div class="figure">
<img src="supplement_files/figure-html/rmseHighSampleSize-1.png" alt="RMSE of the considered methods across 500 replcations calculated in a simulated sample of size 500,000. Sample size is 17,000 rather than 4,250 in Figure \ref{fig:rmseHighBase}." width="100%" />
<p class="caption">(\#fig:rmseHighSampleSize)RMSE of the considered methods across 500 replcations calculated in a simulated sample of size 500,000. Sample size is 17,000 rather than 4,250 in Figure \ref{fig:rmseHighBase}.</p>
</div>

<div class="figure">
<img src="supplement_files/figure-html/rmseHighAuc-1.png" alt="RMSE of the considered methods across 500 replcations calculated in a simulated sample of size 500,000. AUC is 0.85 rather than in Figure \ref{fig:rmseHighBase}." width="100%" />
<p class="caption">(\#fig:rmseHighAuc)RMSE of the considered methods across 500 replcations calculated in a simulated sample of size 500,000. AUC is 0.85 rather than in Figure \ref{fig:rmseHighBase}.</p>
</div>

\newpage
## Treatment interactions

We carried out a smaller set of simulations, in which we assumed true
treatment-covariate interactions. Sample size was set to 4,250 and the AUC of
the true prediction model was set to 0.75. The following scenarios were
considered: 1) 4 true weak positive interactions
($\text{OR}_{Z=1} / \text{OR}_{Z=0}=0.83$); 2) 4 strong positive
interactions ($\text{OR}_{Z=1} / \text{OR}_{Z=0}=0.61$); 3) 2 weak and 2
strong positive interactions; 4) 4 weak negative interactions 
($\text{OR}_{Z=1} / \text{OR}_{Z=0}=1.17$); 5) 4 strong negative interactions 
($\text{OR}_{Z=1} / \text{OR}_{Z=0}=1.39$); 6) 2 weak and 2 strong negative
interactions; 7) combined positive and negative strong interactions. We also
considered constant treatment-related harms applied on the absolute scale to all
treated patients. The exact settings were: 1) absent treatment-related harms; 2)
moderate treatment-related harms, defined as 25\% of the average true benefit of the
scenario without treatment-related harms; 3) strong treatment-related harms
defined as 50\% of the true average benefit of the scenario without
treatment-related harms; 4) negative treatment-related harms (benefit), defined
as an absolute risk reduction for treated patients of 50\% of the true average
benefit of the scenario without treatment-related harms. The exact settings can
be found in Table \@ref(tab:tab2).

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; "><table class="table" style="font-size: 9px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:tab2)Scenario settings of the treatment-covariate interaction scenarios.</caption>
 <thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="6"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Analysis ID</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="9"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Baseline risk</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="5"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">True treatment effect</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Benefit</div></th>
</tr>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Scenario </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Base </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Type </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> N </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AUC </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Treatment-related harm </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b0 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b1 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b2 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b3 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b4 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b5 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b6 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b7 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> b8 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g0 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g1 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g2 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g5 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> g6 </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Before harms </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> After harms </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 649 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 650 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.07 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 651 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 652 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 653 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 654 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.08 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 655 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 656 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.19 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.13 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 657 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.11 </td>
   <td style="text-align:right;"> 0.11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 658 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.11 </td>
   <td style="text-align:right;"> 0.08 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 659 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.11 </td>
   <td style="text-align:right;"> 0.06 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 660 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.11 </td>
   <td style="text-align:right;"> 0.14 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 661 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> 0.06 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 662 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 663 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> 0.03 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 664 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-weak </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> 0.08 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 665 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 666 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 667 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.03 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 668 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-mixed </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.16 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.06 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 669 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 670 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 0.03 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 671 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 0.02 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 672 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> negative-strong </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 0.05 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 673 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> combined </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> absent </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> 0.08 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 674 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> combined </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> moderate-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> 0.06 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 675 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> combined </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> strong-positive </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 676 </td>
   <td style="text-align:right;"> interaction </td>
   <td style="text-align:right;"> combined </td>
   <td style="text-align:right;"> 4,250 </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> negative </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> -0.69 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> 0.10 </td>
  </tr>
</tbody>
</table></div>


<div class="figure">
<img src="supplement_files/figure-html/rmseInteractionPositive-1.png" alt="RMSE of the considered methods across 500 replications calculated in a simulated sample of size 500,000 where treatment-covariate interactions all favoring treatment were considered." width="100%" />
<p class="caption">(\#fig:rmseInteractionPositive)RMSE of the considered methods across 500 replications calculated in a simulated sample of size 500,000 where treatment-covariate interactions all favoring treatment were considered.</p>
</div>
<div class="figure">
<img src="supplement_files/figure-html/rmseInteractionNegative-1.png" alt="RMSE of the considered methods across 500 replications calculated in a simulated sample of size 500,000 where treatment-covariate interactions all favoring the control were considered." width="100%" />
<p class="caption">(\#fig:rmseInteractionNegative)RMSE of the considered methods across 500 replications calculated in a simulated sample of size 500,000 where treatment-covariate interactions all favoring the control were considered.</p>
</div>
<div class="figure">
<img src="supplement_files/figure-html/rmseInteractionCombined-1.png" alt="RMSE of the considered methods across 500 replications calculated in a simulated sample of size 500,000 where treatment-covariate interactions 2 favoring treatment and 2 favoring the control were considered." width="100%" />
<p class="caption">(\#fig:rmseInteractionCombined)RMSE of the considered methods across 500 replications calculated in a simulated sample of size 500,000 where treatment-covariate interactions 2 favoring treatment and 2 favoring the control were considered.</p>
</div>

\newpage
## Empirical illustration

For predicting baseline risk of 30-day mortality we fitted a logistic regression
model with age, Killip class (*Killip*), systolic blood pressure (*sysbp*),
pulse rate (*pulse*), prior myocardial infarction (*pmi*), location of
myocardial infarction (*miloc*) and treatment as the covariates. Baseline
predictions were made setting treatment to 0.




\begin{equation*}
P(outcome=1|X=x) = \text{expit}(lp(x)),
(\#eq:gusto1)
\end{equation*}
where 
\begin{equation*}
\begin{aligned}
lp(x)=& \beta_0 + \beta_1 \text{age} + \beta_2 I(\text{Killip}=II) + \beta_3I(\text{Killip}=III) +\\
&\beta_4 I(\text{Killip}=IV) + \beta_5min(\text{sysbp}, 120) + \beta_6 \text{pulse}+\\
&\beta_7 max(\text{pulse - 50, 0}) + \beta_8 I(\text{pmi}=yes)+\\
&\beta_9 I(\text{miloc}=Anterior) + \beta_9 I(\text{miloc}=Other) +\\
&\gamma\times\text{treatment}
\end{aligned}
(\#eq:gusto2)
\end{equation*}

and $expit(x) = \frac{e^x}{1+e^x}$

\begingroup\fontsize{7}{9}\selectfont

\begin{longtable}[t]{lrrrr}
\caption{(\#tab:unnamed-chunk-3)Coefficients of the prediction model for 30-day mortality, based on the data from GUSTO-I trial.}\\
\toprule
Variable & Estimate & stderror & zvalue & pvalue\\
\midrule
Intercept & -3.020 & 0.797 & -3.788 & 0.000\\
Age & -0.208 & 0.053 & -3.935 & 0.000\\
Killip class = II & 0.077 & 0.002 & 31.280 & 0.000\\
Killip class = III & 0.614 & 0.059 & 10.423 & 0.000\\
Killip class = IV & 1.161 & 0.121 & 9.566 & 0.000\\
Systolic blood pressure & 1.921 & 0.162 & 11.872 & 0.000\\
Pulse rate (1) & -0.039 & 0.002 & -20.332 & 0.000\\
Pulse rate (2) & -0.024 & 0.016 & -1.521 & 0.128\\
Previous MI (yes) & 0.043 & 0.016 & 2.675 & 0.007\\
MI location (Other) & 0.447 & 0.056 & 7.964 & 0.000\\
MI location (Anterior) & 0.286 & 0.135 & 2.126 & 0.033\\
Treatment & 0.543 & 0.051 & 10.625 & 0.000\\
\bottomrule
\end{longtable}
\endgroup{}
