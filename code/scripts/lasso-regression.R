.libPaths(c("C:/Users/vlfgn/Documents/R/win-library/3.3", "C:/Users/vlfgn/Documents/R/win-library/3.3"))
library(glmnet)


library(glmnet)
load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.csv")
scaled_credit = scaled_credit[,-1]

x_train = as.matrix(scaled_credit_train[,-length(scaled_credit_train)])
y_train = as.matrix(scaled_credit_train$balance)

x_test = as.matrix(scaled_credit_test[,-length(scaled_credit_train)])
y_test = as.matrix(scaled_credit_test$balance)

x_full <- as.matrix(scaled_credit[,-length(scaled_credit)])
y_full <- as.matrix(scaled_credit$balance)


#1 Run the corresponding fitting function on the train set using ten-fold cross-validation.
grid = 10^seq(10, -2, length = 100)
set.seed(0)
cv.out_lasso <- cv.glmnet(x_train, y_train, alpha=1, lambda=grid, intercept=FALSE, standardize=FALSE)


#2. Saving list of models(saved in Rdata file at the end)
list_models_lasso = cv.out_lasso


#3. To select the best model:
bestlambda = cv.out_lasso$lambda.min


#4. Plot the cross-validation errors in terms of the tunning 
##  parameter to visualize which parameter gives the "best" model:
png(filename = "../../images/lasso-cross-validation-errors.png", width=800, height=600)
plot(cv.out_lasso)
dev.off()


#5. Once you identify the "best" model, use the test set to compute the test Mean Square Error(test MSE)
lasso.pred = predict(cv.out_lasso, s=bestlambda, newx = x_test)
test_mse_lasso = mean((lasso.pred - y_test)^2)


#6. Last but not least, refit the model on the full data set using the parameter chosen by cross-validation.
##  This fit will give you the "official" coefficient estimates.
lasso_full = glmnet(x_full, y_full, alpha = 1, lambda = bestlambda
                       , intercept = FALSE, standardize = FALSE)
cof_lasso = predict(lasso_full, type = "coefficients", s = bestlambda)[1:length(scaled_credit),]


#full prediction
lasso.pred_full = predict(cv.out_lasso, s = bestlambda, newx = x_full)
full_mse_lasso = mean((lasso.pred_full - y_full)^2)

#saving the the best tunning parameter, list_models_lasso, test_mse_lasso, cof_lasso, full_mse_lasso
par_lasso = bestlambda
save(par_lasso,list_models_lasso, test_mse_lasso, cof_lasso, full_mse_lasso
     , file = "../../data/lasso-regression.Rdata")

#putting the result in the eda-output.txt
sink(file = "../../data/eda-output.txt", append = TRUE)
cat("\n\n")
cat("<<Summary Statistics of Lasso-regression>>\n\n")
cat("1. Test Mean Square Error\n")
test_mse_lasso
cat("\n")
cat("2. Best Model\n")
cat("lambda equals ", par_lasso, "\n")
cat("\n")
cat("3. Official Coefficient\n")
cof_lasso
cat("\n")
sink()