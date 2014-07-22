# run_analysis.R
#
# Script for tidying up Human Activity Recognition (HAR) data collected with
# Samsung smartphones.
#
# Coursera "Getting and Cleaning Data" course project assignment.
#

library(dplyr)

# -------- PREPARATIONS --------

# We expect that the data has been downloaded and extracted and is
# available locally in the "UCI HAR Dataset" subfolder. Make this our
# working directory to start processing the data.
#
setwd("/path/to/getdata/UCI HAR Dataset")


# -------- PHASE 1: Read HAR measurement data ---------

# features.txt lists descriptive names for all the 561 columns (variables)
# in the HAR measurement data. Read the column names into a vector.
#
allColNames <- read.table("features.txt")$V2

# Use grep and a regular expression to pick mean ("-mean()") and standard
# deviation ("-std()") column names and their numbers.
#
meanStdColNames   <- grep("-(mean|std)\\(\\)", allColNames, value=TRUE)
meanStdColNumbers <- grep("-(mean|std)\\(\\)", allColNames, value=FALSE)

# Create a column class vector to be used with read.table(). First fill in
# the vector with "NULL" strings, as we want read.table() to skip most of the
# columns in the HAR measurement data files. Then mark just the mean and
# standard deviation columns to be read as numerics.
#
meanStdColClasses <- rep("NULL", length(allColNames))
meanStdColClasses[meanStdColNumbers] <- "numeric"

# Load and merge HAR training and test data sets from text files. We will only
# read the mean and standard deviation columns, thanks to colClasses. Once the
# data sets are loaded, replace the default V1, V2.. Vn column names with
# the proper mean and std column names from features.txt.
#
data <- read.table("train/X_train.txt", colClasses=meanStdColClasses)
data <- rbind(data, read.table("test/X_test.txt", colClasses=meanStdColClasses))
names(data) <- meanStdColNames


# -------- PHASE 2: Add "activity" column to HAR measurement data ---------

# Add information about activity classes (integer 1-6) for each of our
# measurement data rows - but transform the integer values into human readable
# factors first. The mapping between int values and factor names is stored
# in the activity_labels.txt file.
#
activityLabels <- read.table("activity_labels.txt")
activities <- read.table("train/y_train.txt")
activities <- rbind(activities, read.table("test/y_test.txt"))
activities$V1 <- factor(activities$V1, levels=activityLabels$V1,
                     labels=activityLabels$V2)
names(activities) <- "activity"
data <- cbind(activities, data)


# -------- PHASE 3: Add "subject" column to HAR measurement data ---------

# Add information about subject IDs (integer 1-30) for each of our
# measurement data rows.
#
subjects <- read.table("train/subject_train.txt")
subjects <- rbind(subjects, read.table("test/subject_test.txt"))
names(subjects) <- "subject"
data <- cbind(subjects, data)


# -------- PHASE 4: Create a new tidy summary data set ---------

# At this point the "data" data frame contains a "subject" column,
# an "activity" column and 66 columns of mean() and std() measurements,
# i.e. 68 columns in total. There are 10299 rows of data.
#
# For our summary data set, we want averages of each 66 measurements
# for each possible combination of subject and activity. The end result
# will be a data frame with the original 68 columns and 
# 30 subjects x 6 different activities = 180 rows.
#
# The summary data frame is really easy to construct with the help
# of the dplyr package.
#
summary <- summarise_each(group_by(data, subject, activity), funs(mean))

# Write the summary data frame to a text file.
write.table(summary, "HAR_summary.txt", quote=FALSE, row.names=FALSE)
