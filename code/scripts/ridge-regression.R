library(glmnet)
load('data/new-train-test.RData')
load('data/scale-train-test.RData')


grid <- 10^seq(10, -2, length = 100)
x <- as.matrix(scaled_credit_train[,-length(scaled_credit_train)])
y <- as.matrix(scaled_credit_train$balance)

x_test <- as.matrix(scaled_credit_test[,-length(scaled_credit_train)])
y_test <- as.matrix(scaled_credit_test$balance)

cv.out <- cv.glmnet(x, y, alpha=0, lambda=grid, intercept=FALSE, standardize=FALSE)
plot(cv.out)
bestlambda <- cv.out$lambda.min


ridge.pred = predict(cv.out, s=bestlambda, newx =x_test)
mean(( ridge.pred -y_test)^2)


ridge.mod =glmnet (x[train ,],y[train],alpha =0, lambda =grid ,
                   thresh =1e -12)
ridge.pred=predict (ridge .mod ,s=4, newx=x_test)
> mean(( ridge.pred -y.test)^2)