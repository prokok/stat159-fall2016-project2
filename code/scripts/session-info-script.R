#r packages from this project
library(knitr)
library(rmarkdown)
library(pls)
library(devtools)
library(rmarkdown)
library(glmnet)
library(xtable)



sink('../../session-info.txt')
cat('Session Information\n\n')
print(sessionInfo())
devtools::session_info()
sink()
