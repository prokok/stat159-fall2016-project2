library(pls)
load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.csv")
scaled_credit = scaled_credit[,-1]

y.test = scaled_credit_test$balance
y.test_full = scaled_credit$balance

#1 Run the corresponding fitting function on the train set using ten-fold cross-validation. 
set.seed(0)
pls.fit = plsr(balance~., data = scaled_credit_train, validation='CV', scale = FALSE)


#2. Saving list of models(saved in Rdata file at the end)
list_models_plsr = pls.fit


#3. To select the best model:
M = which(pls.fit$validation$PRESS==min(pls.fit$validation$PRESS))


#4. Plot the cross-validation errors in terms of the tunning 
##  parameter to visualize which parameter gives the "best" model:
png(filename = "../../images/plsr-cross-validation-errors.png", width=800, height=600)
validationplot(pls.fit, val.type="MSEP")
dev.off()


#5. Once you identify the "best" model, use the test set to compute the test Mean Square Error(test MSE)
pls.pred = predict(pls.fit, scaled_credit_test, ncomp=M)
test_mse_plsr = mean((pls.pred - y.test)^2)

#6. Last but not least, refit the model on the full data set using the parameter chosen by cross-validation.
##  This fit will give you the "official" coefficient estimates.
plsr_full = plsr(balance~., ncomp = M, data = scaled_credit)
cof_plsr = t(as.data.frame(coef(plsr_full, ncomp = M, intercept = TRUE)))
rownames(cof_plsr) = ''

#full prediction
pls.pred_full <- predict(pls.fit, scaled_credit, ncomp =M)
full_mse_plsr = mean((pls.pred_full - y.test_full)^2)

#saving the the best tunning parameter, list_models_plsr, test_mse_plsr, cof_plsr, full_mse_plsr
par_plsr = M
save(par_plsr,list_models_plsr, test_mse_plsr, cof_plsr, full_mse_plsr
     , file = "../../data/plsr-regression.Rdata")


#putting the result in the eda-output.txt
sink(file = "../../data/eda-output.txt", append = TRUE)
cat("\n\n")
cat("<<Summary Statistics of Plsr-regression>>\n\n")
cat("1. Test Mean Square Error\n")
test_mse_plsr
cat("\n")
cat("2. Best Model\n")
cat("Compression equals ", par_plsr, "\n")
cat("\n")
cat("3. Official Coefficient\n")
cof_plsr
cat("\n")
sink()