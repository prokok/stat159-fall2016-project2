# Script to be called from command line to perform unit tests:
# Rscript test-that.R
.libPaths(c("C:/Users/vlfgn/Documents/R/win-library/3.3", "C:/Users/vlfgn/Documents/R/win-library/3.3"))
library(testthat)

# loading all function files

source("functions/test-training-functions.R")


files <- list.files("functions")
for (i in 1:length(files)) {
  source(paste0("functions/", files[i]))
}

# run unit tests in folder 'tests/'
test_dir("tests", reporter = "Summary")
