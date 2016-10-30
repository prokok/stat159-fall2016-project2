library(glmnet)
load('../../data/new-train-test.RData')
load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.RData")

grid <- 10^seq(10, -2, length = 100)
x <- as.matrix(scaled_credit_train[,-length(scaled_credit_train)])
y <- as.matrix(scaled_credit_train$balance)

x_test <- as.matrix(scaled_credit_test[,-length(scaled_credit_train)])
y_test <- as.matrix(scaled_credit_test$balance)

x_full <- as.matrix(scaled_credit[,-length(scaled_credit)])
y_full <- as.matrix(scaled_credit$balance)

scaled_credit$balance

cv.out <- cv.glmnet(x, y, alpha=0, lambda=grid, intercept=FALSE, standardize=FALSE)
plot(cv.out)
bestlambda <- cv.out$lambda.min

ridge.pred = predict(cv.out, s=bestlambda, newx =x_test)
mean(( ridge.pred -y_test)^2)

ridge.pred_full = predict(cv.out, s=bestlambda, newx = x_full)
mean((ridge.pred_full - y_full)^2)