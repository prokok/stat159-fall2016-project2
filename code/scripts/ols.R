load('../../data/scale-train-test.RData')
scaled_credit = read.csv("../../data/scaled-credit.RData")

income = credit$Income
limit = credit$Limit
rating = credit$Rating
cards = credit$Cards
age = credit$Age
education = credit$Education
gender = credit$Gender
student = credit$Student
marriage = credit$Married
ethnicity = credit$Ethnicity
balance = credit$Balance

reg = lm(balance ~ income+limit+rating+cards+age+education
         , data = scaled_credit_train)
sum_reg = summary(reg)



save(reg, sum_reg, file = "../../data/regression.RData")