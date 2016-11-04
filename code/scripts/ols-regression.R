load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.csv")
scaled_credit = scaled_credit[,-1]

y.test = scaled_credit_test$balance
y.test_full = scaled_credit$balance

#regression on all the predictor variables
reg = lm(balance ~ income+limit+rating+cards+age+education+gender+student+marriage+asian+caucasian
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

#since there is no significant difference between reg2 and reg3, going to use reg3 for our OLS model
#calculate the test_mse
ols.pred = predict(reg3, newdata = scaled_credit_test)
test_mse_ols = mean((ols.pred - y.test)^2)

#using the predictors in reg3, apply lm function to full data set
reg4 = lm(balance ~ income+limit+cards+student, data = scaled_credit)
reg5 = lm(balance ~ income+limit+rating+cards+age+education+student+gender+marriage+asian+caucasian
          , data = scaled_credit)
cof_ols_2 = coef(reg5)
cof_names = names(cof_ols_2)
cof_ols_2 = rep(0,length(scaled_credit))
names(cof_ols_2) = cof_names
cof_ols_1 = coef(reg4)

for(i in 1:length(cof_ols_1)){
  for(j in i:length(cof_ols_2)){
    if(names(cof_ols_1)[i]==names(cof_ols_2)[j]){
      cof_ols_2[j] = cof_ols_1[i]
      break
    }
    else{cof_ols_2[j] =0}
  }
}

cof_ols = cof_ols_2

sum_ols_full = summary(reg4)
sum_ols_full_all = summary(reg5)

#calculate the full_data_mse
ols.pred_full = predict(reg3, newdata = scaled_credit)
full_mse_ols = mean((ols.pred_full - y.test_full)^2)


#saving the result of test_mse, official coefficients of full data, and full_data_mse
save(reg2,reg3, test_mse_ols, cof_ols, full_mse_ols, sum_ols_full,file = "../../data/ols-regression.Rdata")

#residual plot of ols on test dataset.
png(filename = "../../images/ols-residuals.png", width=800, height=600)
plot(reg3, which=1)
dev.off()



#putting the result in the eda-output.txt
sink(file = "../../data/eda-output.txt", append = TRUE)
cat("\n\n")
cat("<<Summary Statistics of OLS>>\n\n")
cat("1. Test Mean Square Error\n")
test_mse_ols
cat("\n")
cat("2. Best Model\n")
cat("balance ~ income+limit+cards+student\n")
cat("\n")
cat("3. Official Coefficient\n")
reg4$coefficients
cat("\n")
sink()

