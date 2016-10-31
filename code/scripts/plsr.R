library(pls)
load('../../data/scale-train-test.RData')
load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.RData")

y.test = scaled_credit_test$balance
y.test_full = scaled_credit$balance

set.seed(0)
pls.fit <- plsr(balance~., data = scaled_credit_train, validation='CV')
summary(pls.fit)
M <- which(pls.fit$validation$PRESS==min(pls.fit$validation$PRESS))

validationplot(pls.fit, val.type="MSEP")

##code to subset pcr.fit$validation$PRESS to the 10th parameter
m = as.numeric(which(pls.fit$validation$PRESS==min(pls.fit$validation$PRESS)))

#ncomp = m  (in this case m=10)
pls.pred <- predict(pls.fit, scaled_credit_test, ncomp=m)
#find the MSE
mean((pcr.pred - y.test)^2)

#full prediction
pls.pred_full <- predict(pls.fit, scaled_credit, ncomp =m)
mean((pls.pred_full - y.test_full)^2)

