This is the data/ directory.  This contains all of the .csv files (data sets) and .RData files produced in our scripts.  
This directory also contains the eda-output.txt document which shows useful information of correlation between variables in our data set.

eda-output.txt contains 3 parts.
- The first part contains summary statistics of each quantitative variable; followed by a correlation matrix of these variables.
- The second part explores the statistics of each qualitative variable.
- The third part has the ANOVA analysis data for the qualitative variables.  This is important because this way, we can see which qualitative variable contributes significantly to our response variable, balance.

This directory also holds all of the .csv files which are all of our data sets.
Credit.csv is our original data set from the book "An Introduction to Statistical Learning" by James et al.
the new-credit.csv data set is our premodeling processing of the data set, while scaled-credit.csv is the scaled version of new-credit.csv

The .RData files hold the data matrices necessary to be carried over to our regression scripts.
