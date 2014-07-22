gettingandcleaningdata
======================

Coursera "Getting and Cleaning Data" project assignment files.

This repository contains three files:
* run_analysis.R - script for tidying up Human Activity Recognition (HAR) measurement data
* CodeBook.md - describes the data and the variables
* README.md - explains how everything works (you are reading it right now!)

## The Human Activity Recognition Measurement Data

The `run_analysis.R` script processes Human Activity Recognition (HAR) measurement data, which
is a collection of text files containing sensor readings from Samsung Galaxy S smartphones,
carried around by 30 volunteers in an experiment done in Spain in 2012. You can read more here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is provided as a single zip file for Coursera students:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

`run_analysis.R` expects the unzipped data to be present locally. The `setwd` command
should be modified to point to the "UCI HAR Dataset" top level directory.

## Phase 1: Reading HAR Measurement Data

As the original HAR measurement data is quite big and the assignment was to use the
mean and standard deviation variables only, `run_analysis.R` starts by loading `features.txt`
and looking for all the column names with `-mean()` or `-std()`. The names and numbers
of the these columns are stored.

The column numbers are used to create a filter (`meanStdColClasses`) to ignore all the
unnecessary columns when reading the HAR training and testing data sets. The data sets
are merged simply by `rbind`.



