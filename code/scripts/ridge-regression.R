install.packages('glmnet')
library(glmnet)
load('data/train-test.R')

#x = matrix
#y = vector

set.seed(1)
grid <- 10^seq(10, -2, length = 100)
cv.out = cv.glmnet(as.matrix(train), y, alpha=0, lambda=grid, intercept=FALSE, standardize=FALSE)
plot(cv.out)
