### Human Activity Recognition (HAR) Summary Data Variables

Description for variables in HAR_summary.txt created by run_analysis.R.

The file has a heading row and then one data row for each possible
subject & activity combination. 68 columns, separated by single spaces.

subject
* ID number for the subject, i.e. a person in the original HAR study
* integer
* possible values: 1..30

activity
* activity class
* string/factor
* possible values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

measurement averages
* 66 variables for averages of original HAR measurements
* numeric
* possible values: -1..1

The measurement average variables use the same naming as in the original
HAR measurement data. The naming convention and explanations for
the original variables can be found in the `features_info.txt` text file that
comes with the HAR data set.

