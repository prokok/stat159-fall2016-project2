install.packages('glmnet')
library(glmnet)
load('data/new-train-test.RData')
load('data/scale-train-test.RData')

#x = matrix
#y = vector


grid <- 10^seq(10, -2, length = 100)
x <- as.matrix(scaled_credit_train[,-length(scaled_credit_train)])
y <- as.matrix(scaled_credit_train$balance)

cv.out <- cv.glmnet(x, y, alpha=0, lambda=grid, intercept=FALSE, standardize=FALSE)
plot(cv.out)
bestlambda <- cv.out$lambda.min
train.lambdas <- cv.out$lambda

save(train.lambdas, file='data/train-lambdas.RData')

predict (cv.out, type= "coefficients", s= bestlambda) [1:20,]
  