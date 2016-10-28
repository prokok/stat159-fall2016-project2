load("../../data/new-train-test.Rdata")
load("../../data/scale-train-test.RData")
library(glmnet)

x1 = scaled_credit_train[,-length(scaled_credit_train)]
y1 = scaled_credit_train$balance

x=as.matrix(x1)
y=as.matrix(y1)

grid = 10^seq(10,-2,length=100)
ridge.mod =glmnet (x,y,alpha =0, lambda =grid)

dim(coef(ridge.mod))
ridge.mod
head(ridge.mod)
ridge.mod$lambda[50]
names(ridge.mod)
