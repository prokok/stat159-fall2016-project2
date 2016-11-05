Code
***


There are 3-sub directories in Code: functions, scripts, tests and one R script, test-that.R which is used to run the unit test on the ols-regression-functions.R via test-ols-regression-functions.R.

1. The functions directory contains 1 R script, ols-regression-functions.R
	
	In this script, we have made functions used in analyzing ols regression.


2. The scripts directory contains all of the code for each regression test, as well as eda-script.R, premodeling-data-processing.R and session-info-script.R

	eda-script.R contains the code to produce all of the images in the images directory, as well as the eda-output.txt file and the .RData files.
premodeling-data-processing.R contains the code that rearranges the data set, credit.  This generates new data sets, new_credit and scaled_credit
session-info-script.R just contains 3 lines of code to produce.

	eda-script produces plots, eda-output.txt, correlation-matrix.RData.
	```
		#excuting eda-script.R
		make eda
	```
	
	
	ols-regression.R, ridge-regression.R, lasso-regression.R, pcr-regression.R, plsr-regression.R produces plots and Rdata files needed for Rmd files
	```
		#excuting all the regression scripts
		make regressions
	```
	
	session-info-script.R produces session-info.txt
	```
		#excuting session-info-script.R
		make session
	```

3. Inside the tests, there is a test-regression.R, the unit test Rscript on ols-regression-functions.R. Unlike previous scripts, it will be executed indirectly via test-that.R on its parent directory. 

	```
		#excuting unit test on ols-regression-functions.R 
		make test
	
	```

4. test-that.R executes the unit test on ols-regression-functions.R via test-ols-regression-functions.R. 


Author: PHILHOON OH, JAMIE STANKIEWIZ

