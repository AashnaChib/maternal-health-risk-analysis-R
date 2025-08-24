# Maternal Health Risk Analysis in R

Predicting maternal risk levels from clinical measurements using R.  
Compares logistic regression and decision trees, includes model selection, and reports clear evaluation metrics.

## Overview
- Goal: classify patients into risk categories and identify the strongest predictors
- Data: 1,013 observations from rural hospitals and clinics in Bangladesh, with six predictors and a three-level target
- Tools: R with tidyverse, ggplot2, caret, rpart, pROC
- Methods: data cleaning, EDA, train–test split, model selection, pruning, and model comparison

## Data
Source: UCI Machine Learning Repository  
URL: https://archive.ics.uci.edu/dataset/863/maternal+health+risk

Variables used
- Age, SystolicBP, DiastolicBP, Blood Sugar, BodyTemp, Heart Rate
- Target: RiskLevel with three classes low, mid, high

## Results
- Linear regression highlighted Blood Sugar as the strongest signal, with SystolicBP and BodyTemp also significant
- Best interpretable classifier: pruned decision tree with 5 terminal nodes
- Test error rate approximately 36.45 percent on the held-out set
- Key predictors for the tree: Blood Sugar, SystolicBP, BodyTemp
- Heart Rate contributed little, DiastolicBP showed moderate or limited role depending on model

