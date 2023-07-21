feasibleforest
================

This work is supported via NSF fellowship award DBI-2208901 to Renata
Diaz.

This is a) an R package in-development and b) a demonstration of a
workflow using a random forest algorithm to accelerate making
comparisons between the [feasible
set](https://onlinelibrary.wiley.com/doi/10.1111/ele.12154) and
empirically- or theoretically-generated species abundance distributions
(e.g. the comparisons made
[here](https://github.com/diazrenata/sad-divergence)). The
[feasiblesads](https://github.com/diazrenata/feasiblesads) package
samples from the feasible set directly, but this becomes computationally
intractable for large combinations of S and N or simply to perform
repeatedly in short periods of time. This package uses a random forest
model, trained on true samples drawn from feasible sets, to predict the
statistical characteristics of the feasible set for a given S and N and
compare an observed SAD to these predictions. It is intended to expedite
comparisons between observed SADs and the feasible set, particularly for
instances where one wishes to make many comparisons within the a
consistent general range of combinations of S and N, but not to resample
the feasible set for every possible combination of S and N within that
state space. It may not be as appropriate for comparisons involving
unusual combinations of S and N or combinations not part of the state
space the model was originally trained on.

## Intended use case

This was developed in response to the need to rapidly compare the
results of simulation models to the feasible set. While these models
have relatively predictable *approximate* values for S and N, actual
outcomes can vary. To do this at scale, we would need to re-sample the
feasible set for every novel combination of S and N, which represents an
enormous computational load and a significant barrier to executing these
analyses.

Feasible sets for similar combinations of S and N have similar
statistical properties (i.e., the SADs in a feasible set for an S of 100
and an N of 400 are similar to the SADs in a feasible set for S of 101
and N of 395). Therefore, rather than resample for every SxN pairing,
this package trains a random forest algorithm on the statistical
properties of a relatively small subset of SxN pairings, and uses the
trained model to predict the statistical properties of feasible sets
with novel SxN pairings. The speciifc properties used here are the mean
and standard deviation of Hill numbers (q=1) for SADs in the feasible
set. These values can then be used to compare “observed” SADs to the
feasible set by calculating a z-score of the “observed” SAD’s Hill
number (q = 1) value compared to the Hill numbers predicted for the
feasible set with the corresponding S and N.

## Workflow overview

1.  Generate samples from the feasible set for a “sparse” set of SxN
    combinations distributed over a broad range. (This implementation
    uses 1476 combinations of S ranging from 3-200 and N ranging from
    57-19979).
2.  For all samples, calculate the Hill numbers of the SADs. For each
    SxN combination, calculate the mean and standard deviation Hill
    number associated with that SxN.
3.  Train random forest models to predict the mean hill number given S
    and N, and to predict the standard deviation hill number given S and
    N.
4.  Use the trained models to generate predicted mean + sd hill numbers
    from a new S and N.
5.  Calculate the z-score of an “observed” Hill number compared to these
    predictions.

## Validation and demonstrations

See [this
report](https://github.com/diazrenata/feasible-forest/blob/main/reports/comparing_rf_to_true.md)
for a comparison of the true mean and SD scores compared to those
predicted by the random forest model, on a withheld test dataset.

See [this
report](https://github.com/diazrenata/feasible-forest/blob/main/reports/report.md)
for a comparison of the percentile scores and z scores obtained
comparing logseries SADs with different values of S and N to a) the true
feasible set and b) the random-forest predictions using this workflow.

See [this
report](https://github.com/diazrenata/feasible-forest/blob/main/reports/all_di_comparison.md)
for an application of this workflow to the data used
[here](https://github.com/diazrenata/scadsanalysis).

## Instructions and suggestions for wider use

This R package is undergoing active development and does not yet have a
stable release. Using code or objects directly drawn from this repo is
therefore not recommended (or, subject to use-at-your-own-risk!). It may
be more reliable to re-implement the higher-level approach within your
own codebase. If you would like to use this code or have questions about
the workflow modeled here, RMD is more than happy to chat via GitHub
issues.

For the intrepid:

`obs_to_forest_z` calculates the Z score of an observed Hill number
(q=1) to the expectations from a feasible set.

`obs_to_norm_p` calculates a p value for the null hypothesis of an
observed Hill number coming from the normal distribution of hill numbers
for the corresponding feasible set.

These functions are probably most accurate for S and N within the range
sampled by the training values (i.e. ballpark S from 3-200, N from
50-20000).
