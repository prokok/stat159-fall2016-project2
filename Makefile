.PHONY: all data tests eda ols ridge lasso pcr plsr regressions report slides session clean

all: eda regressions report

data:
	curl -o data/Advertising.csv http://www-bcf.usc.edu/~gareth/ISL/Advertising.csv
	
tests: code/functions/test-training-functions.R
	Rscript code/functions/test-training-functions.Rscript
	
eda: code/scripts/eda-script.R data/Advertising.csv
	Rscript code/scripts/eda-script.R

ols:

ridge:

lasso:

pcr:

plsr:

regression: data/Advertising.csv code/scripts/ols-regression.R plsr-regression.R ridge-regression.R lasso-regression.R pcr-regression.R premodeling-data-processing.R
	Rscript ................

report: report/report.Rmd
	cd report && Rscript -e 'library(rmarkdown); render('report.Rmd')'

slides: slides/report-slides.Rmd
	cd slides && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

session: code/scripts/session-info-script.R
	cd code/scripts && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

clean:
	rm -f report/report.pdf