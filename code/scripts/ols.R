load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.RData")

y.test = scaled_credit_test$balance
y.test_full = scaled_credit$balance

#regression on all the predictor variables
reg = lm(balance ~ income+limit+rating+cards+age+education+student+gender+marriage+asian+caucasian
         , data = scaled_credit_train)
sum_reg = summary(reg)

#regression on all the predictor variables except gender, marriage, ethnicity
#becuase eda-output shows that there is no significant different among gender, marraige, ethnicity on balance
reg2 = lm(balance ~ income+limit+rating+cards+age+education+student, data = scaled_credit_train)
sum_reg2 = summary(reg2)

#regression on the income, limit, cards, students 
#using the result from reg2 only significant predictor variables from sum_reg2
reg3 = lm(balance ~ income+limit+cards+student, data = scaled_credit_train)
sum_reg3 = summary(reg3)
plot(reg3)

#since there is no significant difference between reg2 and reg3, going to use reg3 for our OLS model
ols.pred = predict(reg3, newdata = scaled_credit_test)
mean((ols.pred - y.test)^2)
ols.pred_full = predict(reg3, newdata = scaled_credit)
mean((ols.pred_full - y.test_full)^2)
 
save(reg, sum_reg, file = "../../data/regression.RData")