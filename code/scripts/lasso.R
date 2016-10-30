library(glmnet)
load('../../data/new-train-test.RData')
load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.RData")

grid = 10^seq(10, -2, length = 100)
x_train = as.matrix(scaled_credit_train[,-length(scaled_credit_train)])
y_train = as.matrix(scaled_credit_train$balance)

x_test = as.matrix(scaled_credit_test[,-length(scaled_credit_train)])
y_test = as.matrix(scaled_credit_test$balance)

x_full <- as.matrix(scaled_credit[,-length(scaled_credit)])
y_full <- as.matrix(scaled_credit$balance)

set.seed(1)
cv.out_lasso <- cv.glmnet(x_train, y_train, alpha=1, lambda=grid, intercept=FALSE, standardize=FALSE)
plot(cv.out_lasso)
bestlambda <- cv.out_lasso$lambda.min

lasso.pred = predict(cv.out_lasso, s=bestlambda, newx =x_test)
mean((lasso.pred -y_test)^2)

lasso.pred_full = predict(cv.out_lasso, s=bestlambda, newx = x_full)
mean((lasso.pred_full - y_full)^2)

out_lasso = glmnet(x_full,y_full,alpha=1,lambda=grid)

lasso.coeff = predict(out_lasso, type = "coefficients", s=bestlambda)
lasso.coeff

