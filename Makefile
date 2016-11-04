#variables
CS = code/scripts
CF = code/functions
AD = data/credit.csv 

# phony targets
.PHONY: all data eda pre traintest tests ols ridge lasso pcr plsr regressions report slides session clean

all: eda pre regressions report

#download the Credit.csv
data: 
	curl -O "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"
	mv credit.csv data

#executes the code in eda-script.R	
eda: $(CS)/eda-script.R $(AD)
	cd $(CS); Rscript $(<F)

#premodeling data processing 
pre: $(CS)/premodeling-data-processing.R $(AD)	
	cd $(CS); Rscript $(<F)

#producing test and training set
traintest: $(CS)/test-training.R data/scaled-credit.csv	
	cd $(CS); Rscript $(<F)

##tests: $(CF)/test-training-functions.R
##Rscript $(CF)/test-training-functions.Rscript	
	
#Runing OLS regression script
ols: $(CS)/ols-regression.R data/scaled-credit.csv data/scale-train-test.RData
	cd $(CS); Rscript $(<F)
	
#Runing RIDGE regression script
ridge: $(CS)/ridge-regression.R data/scaled-credit.csv data/scale-train-test.RData
	cd $(CS); Rscript $(<F)
	
#Runing LASSO regression script
lasso: $(CS)/lasso-regression.R data/scaled-credit.csv data/scale-train-test.RData
	cd $(CS); Rscript $(<F)
	
#Runing PCR regression script
pcr: $(CS)/pcr-regression.R data/scaled-credit.csv data/scale-train-test.RData
	cd $(CS); Rscript $(<F)
	
#Runing PLSR regression script
plsr: $(CS)/plsr-regression.R data/scaled-credit.csv data/scale-train-test.RData
	cd $(CS); Rscript $(<F)	
	

#Running all the regression scripts at once
regressions: ols ridge lasso pcr plsr
	
	
report: report/report.Rmd data/*.Rdata data/*.RData data/*.csv
	cd report && Rscript -e 'library(rmarkdown); render('report.Rmd')'

slides: slides/report-slides.Rmd data/*.Rdata data/*.RData data/*.csv
	cd slides && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

session: $(CS)/session-info-script.R
	cd $(CS) && Rscript -e 'library(rmarkdown); render('report-slides.Rmd')'

clean:
	rm -f report/report.pdf