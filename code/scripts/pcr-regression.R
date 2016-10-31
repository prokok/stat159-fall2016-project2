library(pls)
load('../../data/new-train-test.RData')
load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.csv")
scaled_credit = scaled_credit[,-1]

#x[test,] = scaled_credit_test
y.test <- scaled_credit_test$balance
y.test_full <- scaled_credit$balance

set.seed(0)
pcr.fit <- pcr(balance~., data = scaled_credit_train[,-1], validation='CV')
pcr.fit$validation$PRESS
validationplot(pcr.fit, val.type="MSEP")
summary(pcr.fit)
#m = pcr.fit$validation$PRESS[which(min(pcr.fit$validation$PRESS))]
#which(min(pcr.fit$validation$PRESS))

#pcr.fit$validation$PRESS
#min(pcr.fit$validation$PRESS)
#str(pcr.fit$validation$PRESS)

##code to subset pcr.fit$validation$PRESS to the 10th parameter
M <- which(pcr.fit$validation$PRESS==min(pcr.fit$validation$PRESS))

#ncomp = m  (in this case m=10)
pcr.pred <- predict(pcr.fit, scaled_credit_test, ncomp=M)
#find the MSE
mean((pcr.pred - y.test)^2)


#full prediction
pcr.pred_full <- predict(pcr.fit, scaled_credit, ncomp =M)
mean((pcr.pred_full - y.test_full)^2)
