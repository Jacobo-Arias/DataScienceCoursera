# Getting and Cleaning Data Final Project

This project contains one R script, `run_analysis.R`, which will calculate means per activity, per subject of the mean and Standard deviation of the Human Activity Recognition Using Samsung Galaxy S Smartphones. This dataset should be [downloaded](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extracted in the same folder as the script

## Steps

    1. Make sure that the UCI HAR Dataset folder and the `run_analysis.R` script are in the same directory
    2. Run the script
    3. See `run_data_summary.txt` as document with tidy data

## Required R Packages

The R package `dplyr` is required to run this script. This maybe installed with,

```{r}
install.package("dplyr")
```