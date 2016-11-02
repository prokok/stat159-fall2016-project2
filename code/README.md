This directory (code) contains 3 subdirectories: functions/ scripts/ tests/

The functions/ directory contains 1 R script, test-training-functions.R
In this script, we have subsetted our data set credit into 2 subsets: new_credit_train (randomly selected 300 rows from new_credit) and new_credit_test(remaining 100 rows from new_credit)
scaled_credit_train is 300 randomly selected rows from scaled_credit, while scaled_credit_test is the remaining 100 rows from scaled_credit
These subsets are useful and necessary for implementing the regressions.

The scripts/ directory contains all of the code for each regression test, as well as eda-script.R, premodeling-data-processing.R and session-info-script.R
eda-script.R contains the code to produce all of the images in the ../../images/ directory, as well as the eda-output.txt file and the .RData files.
premodeling-data-processing.R contains the code that rearranges the data set, credit.  This generates 2 new data sets, new_credit and scaled_credit
session-info-script.R just contains 3 lines of code to produce ../session-info.txt

The tests/ directory contains

