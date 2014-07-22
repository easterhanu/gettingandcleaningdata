gettingandcleaningdata
======================

Coursera "Getting and Cleaning Data" project assignment files.

This repository contains three files:
* run_analysis.R - script for tidying up Human Activity Recognition (HAR) measurement data
* CodeBook.md - describes the data and the variables
* README.md - explains how everything works (you are reading it right now!)

### The Human Activity Recognition Measurement Data

The `run_analysis.R` script processes Human Activity Recognition (HAR) measurement data, which
is a collection of text files containing sensor readings from Samsung Galaxy S smartphones,
carried around by 30 volunteers in an experiment done in Spain in 2012. You can read more here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is provided as a single zip file for Coursera students:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

`run_analysis.R` expects the unzipped data to be present locally. The `setwd` command
should be modified to point to the "UCI HAR Dataset" top level directory.

### Phase 1: Read HAR Measurement Data

As the original HAR measurement data is quite big and the assignment was to use the
mean and standard deviation variables only, `run_analysis.R` starts by loading `features.txt`
and looking for all the column names with `-mean()` or `-std()` in them. The names and numbers
of the these columns are stored.

The column numbers are then used to create a filter vector (`meanStdColClasses`) to ignore
all the unnecessary columns when reading the HAR training and testing data sets. The data
sets are merged simply by `rbind`.

After phase 1, the `data` data frame should contain 10299 rows of measurement data, divided
into 66 columns:

```
tBodyAcc-mean()-X tBodyAcc-mean()-Y ... fBodyBodyGyroJerkMag-std()
0.28858451 -2.029417e-02 ... -0.99069746
```

### Phase 2: Add the Activity Column

In the second phase, `run_analysis.R` loads and merges the activity class information for
the measurements from the `train/y_train.txt` and `test/y_test.txt`files. These files
have numeric activity class values (1-6), which are translated into human readable factor
names (WALKING, SITTING etc.) using the mappings in `activity_labels.txt`. Finally, the
activity class factors are added as the "activity" column into our `data` data frame:

```
activity tBodyAcc-mean()-X tBodyAcc-mean()-Y ... fBodyBodyGyroJerkMag-std()
STANDING 0.28858451 -2.029417e-02 ... -0.99069746
```

### Phase 3: Add the Subject Column

In the third phase, `run_analysis.R` load and merges the subject information (ID numbers
1-30 for persons that participated in the HAR study) from the `train/subject_train.txt`
and `test/subject_test.txt` files. Subject ID numbers are added as the "subject" column
into our `data` data frame:

```
subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y ... fBodyBodyGyroJerkMag-std()
1 STANDING 0.28858451 -2.029417e-02 ... -0.99069746
```


