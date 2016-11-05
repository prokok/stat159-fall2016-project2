#Stat159-fall2016-project2
***

This repository contains the Project2 for the fall 2016, Statistics 159 at UC Berkeley.

This homework is about analyzing the Credit.csv using OLS, RR, LASSO, PCR, PLSR methods and finding the best model among them.

In this repository, there are 5 directories: code, data, images, report, slides

Overview of the Repository Structure
	
	
	```
		stat159-fall2016-project2/
			README.md
			Makefile
			LICENSE
			session-info.txt
			.gitignore
			code/
				functions/
					...
				scripts/
					...
				tests/
					...
			data/
				Credit.csv
				...
			images/
				...
			report/
				report.pdf
				report.Rmd
				sections/
					00-abstract.Rmd
					01-introduction.Rmd
					02-data.Rmd
					03-methods.Rmd
					04-analysis.Rmd
					05-results.Rmd
					06-conclusions.Rmd
			slides/
				...
	```

1. 'data' contains credit.csv, eda-output.txt, ols-regression.RData, ridge-regression.RData, lasso-regression.RData, pcr-regression.RData, plsr-regression.RData, anova-qual.Rdata, correlation-matrix.RData, scaled-credit.csv, scale-train-test.Rdata with its own README.md explaining 'data' structure in more details.

	```
		#generating files in data directory
		make data
		make eda
		make pre
		make traintest
		make regressions
	```


2. 'code' contains 3-sub directories: functions, scripts, tests with its own README.md explaining 'code' structure in more details and one test-that.R script.


3. 'images' contains 22 png files which are produced by either eda-script.R or each methods of regression-script.R

	```
		#generating plots from eda-cript.R
		make eda
	```

	```
		#generating plots from each regression methods
		make regressions   
	```

4. 'report' contains report.Rmd generating report.pdf.
	
	```
		#generating report.pdf from report.Rmd
		make report
	```
	
5. 'slides' contains report-slides.Rmd generating reports-slides.html
	
	```
		#generating report-slides.html from report-slides.Rmd
		make slides
	```

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />All media content (e.g. paper/report, and images) licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

All code licensed under MIT License

Author: PHILHOON OH, JAMIE STANKIEWIZ
