load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.RData")

reg = lm(balance ~ income+limit+rating+cards+age+education+student
         , data = scaled_credit_train)
cor(scaled_credit_train)
sum_reg = summary(reg)

test=cbind(scaled_credit_train$gender,scaled_credit_train$student,scaled_credit_train$marraige)
cor(test)


save(reg, sum_reg, file = "../../data/regression.RData")