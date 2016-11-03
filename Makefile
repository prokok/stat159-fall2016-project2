#need to have vairables
#need to have Make automatic variables
#include comments for rules, targets, or dependencies


.PHONY: all data tests eda ols ridge lasso pcr plsr regressions report slides session clean

all: eda regressions report

data:
	curl -o data/Advertising.csv http://www-bcf.usc.edu/~gareth/ISL/Advertising.csv
	
tests: code/functions/test-training-functions.R
	Rscript code/functions/test-training-functions.Rscript
	
eda: code/scripts/eda-script.R data/Advertising.csv
	Rscript code/scripts/eda-script.R

ols: data/Advertising.csv code/scripts/ols-regression.Rmd
	Rscript code/scripts/ols-regression.R

ridge: data/Advertising.csv code/scripts/ridge-regression.R
	Rscript code/scripts/ridge-regression.R

lasso: data/Advertising.csv code/scripts/lasso-regression.R
	Rscript code/scripts/lasso-regression.R

pcr: data/Advertising.csv code/scripts/pcr-regression.R
	Rscript code/scripts/pcr-regression.R

plsr: data/Advertising.csv code/scripts/plsr-regression.R
	Rscript code/scripts/plsr-regression.R

regression:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

report: report/report.Rmd
	cd report && Rscript -e 'library(rmarkdown); render('report.Rmd')'

slides: slides/report-slides.Rmd
	cd slides && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

session: code/scripts/session-info-script.R
	cd code/scripts && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

clean:
	rm -f report/report.pdf