.libPaths(c("C:/Users/vlfgn/Documents/R/win-library/3.3", "C:/Users/vlfgn/Documents/R/win-library/3.3"))
library(pls)

library(pls)
load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.csv")
scaled_credit = scaled_credit[,-1]

y.test = scaled_credit_test$balance
y.test_full = scaled_credit$balance

#1 Run the corresponding fitting function on the train set using ten-fold cross-validation. 
set.seed(0)
pcr.fit <- pcr(balance~., data = scaled_credit_train, validation='CV', scale = FALSE)


#2. Saving list of models(saved in Rdata file at the end)
list_models_pcr = pcr.fit


#3. To select the best model:
M = which(pcr.fit$validation$PRESS==min(pcr.fit$validation$PRESS))


#4. Plot the cross-validation errors in terms of the tunning 
##  parameter to visualize which parameter gives the "best" model:
png(filename = "../../images/pcr-cross-validation-errors.png", width=800, height=600)
validationplot(pcr.fit, val.type="MSEP")
dev.off()


#5. Once you identify the "best" model, use the test set to compute the test Mean Square Error(test MSE)
pcr.pred <- predict(pcr.fit, scaled_credit_test, ncomp=M)
test_mse_pcr = mean((pcr.pred - y.test)^2)


#6. Last but not least, refit the model on the full data set using the parameter chosen by cross-validation.
##  This fit will give you the "official" coefficient estimates.
pcr_full = pcr(balance~., ncomp = M, data = scaled_credit)
cof_pcr = t(as.data.frame(coef(pcr_full, ncomp = M, intercept = TRUE)))
rownames(cof_pcr) = ''

#full prediction
pcr.pred_full <- predict(pcr.fit, scaled_credit, ncomp =M)
full_mse_pcr = mean((pcr.pred_full - y.test_full)^2)

#saving the the best tunning parameter, list_models_pcr, test_mse_pcr, cof_pcr, full_mse_pcr
par_pcr = M
save(par_pcr,list_models_pcr, test_mse_pcr, cof_pcr, full_mse_pcr
     , file = "../../data/pcr-regression.Rdata")

#putting the result in the eda-output.txt
sink(file = "../../data/eda-output.txt", append = TRUE)
cat("\n\n")
cat("<<Summary Statistics of Pcr-regression>>\n\n")
cat("1. Test Mean Square Error\n")
test_mse_pcr
cat("\n")
cat("2. Best Model\n")
cat("Compression equals ", par_pcr, "\n")
cat("\n")
cat("3. Official Coefficient\n")
cof_pcr
cat("\n")
sink()