#need to have Make automatic variables
#include comments for rules, targets, or dependencies

#variables
CS = code/scripts
CF = code/functions


.PHONY: all data tests eda ols ridge lasso pcr plsr regressions report slides session clean

all: eda regressions report

data:
	curl -o data/Advertising.csv http://www-bcf.usc.edu/~gareth/ISL/Advertising.csv
	
tests: $(CF)/test-training-functions.R
	Rscript $(CF)/test-training-functions.Rscript
	
eda: $(CS)/eda-script.R data/Advertising.csv
	Rscript $(CS)/eda-script.R

#beginning of regression scripts
ols: data/Advertising.csv $(CS)/ols-regression.Rmd data/scaled-credit.csv data/scale-train-test.RData
	Rscript $(CS)/ols-regression.R

ridge: data/Advertising.csv $(CS)/ridge-regression.R data/scaled-train-test.RData data/scaled-credit.csv
	Rscript $(CS)/ridge-regression.R

lasso: data/Advertising.csv $(CS)/lasso-regression.R data/scaled-train-test.RData data/scaled-credit.csv
	Rscript $(CS)/lasso-regression.R

pcr: data/Advertising.csv $(CS)/pcr-regression.R data/scale-train-tests.RData data/scaled-credit.csv
	Rscript $(CS)/pcr-regression.R

plsr: data/Advertising.csv $(CS)/plsr-regression.R data/scale-train-test.RData data/scaled-credit.csv
	Rscript $(CS)/plsr-regression.R
#end of regression scripts
	
#code to produce all of the regression scripts
regression:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

report: report/report.Rmd data/*.Rdata data/*.RData data/*.csv
	cd report && Rscript -e 'library(rmarkdown); render('report.Rmd')'

slides: slides/report-slides.Rmd data/*.Rdata data/*.RData data/*.csv
	cd slides && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

session: $(CS)/session-info-script.R
	cd $(CS) && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

clean:
	rm -f report/report.pdf