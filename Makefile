#variables
CS = code/scripts
CF = code/functions
AD = data/credit.csv 
D1 = data/scaled-credit.csv
D2 = data/scale-train-test.RData

# phony targets
.PHONY: all data eda pre traintest tests ols ridge lasso pcr plsr regressions report slides session clean

all: eda pre traintest regressions report

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
#run the unit tests on test-regression.R
#tests: code/test-that.R code/tests/test-regression.R
#	cd code; Rscript $(<F)
	
#Runing OLS regression script
ols: $(CS)/ols-regression.R $(D1) $(D2)
	cd $(CS); Rscript $(<F)
	
#Runing RIDGE regression script
ridge: $(CS)/ridge-regression.R $(D1) $(D2)
	cd $(CS); Rscript $(<F)
	
#Runing LASSO regression script
lasso: $(CS)/lasso-regression.R $(D1) $(D2)
	cd $(CS); Rscript $(<F)
	
#Runing PCR regression script
pcr: $(CS)/pcr-regression.R $(D1) $(D2)
	cd $(CS); Rscript $(<F)
	
#Runing PLSR regression script
plsr: $(CS)/plsr-regression.R data/scaled-credit.csv data/scale-train-test.RData
	cd $(CS); Rscript $(<F)	
	

#Running all the regression scripts at once
regressions: 
	make ols
	make ridge
	make lasso
	make pcr
	make plsr
	
#Makeing report.pdf
report: report/report.Rmd data/*.Rdata data/*.RData data/*.csv
	cd report; Rscript -e '.libPaths(c("C:/Users/vlfgn/Documents/R/win-library/3.3", "C:/Users/vlfgn/Documents/R/win-library/3.3")); library(rmarkdown); render("report.Rmd")'

#Making slides
slides: slides/report-slides.Rmd data/*.Rdata data/*.RData data/*.csv
	cd slides; Rscript -e '.libPaths(c("C:/Users/vlfgn/Documents/R/win-library/3.3", "C:/Users/vlfgn/Documents/R/win-library/3.3")); library(rmarkdown); render("report-slides.Rmd")'

#making session.info.txt
session: 
	bash session.sh

#remove the report.pdf 
clean:
	rm -f report/report.pdf