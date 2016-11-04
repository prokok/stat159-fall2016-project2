#r packages from this project
library(knitr)
library(rmarkdown)
library(pls)
library(devtools)


sink('../../session-info.txt')
cat('Session Information\n\n')
print(sessionInfo())
devtools::session_info()
sink()
