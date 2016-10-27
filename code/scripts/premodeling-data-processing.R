#loading credit.csv
credit = read.csv('../../data/credit.csv')
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


#Dummy out categorical Variables one by one in order to apprioate name to colums
temp_gender = model.matrix(balance~gender)
temp_student = model.matrix(balance~student)
temp_married = model.matrix(balance~marriage)
temp_ethnicity = model.matrix(balance~ethnicity)

#Removing column of ones, and appending Balance on categorical variables one by one for naming columns appropriately.
#adding afriacnamerican column in new_ethnicity(instead of using 2 variables, using 3 variables for analysis)
new_gender = cbind(female = temp_gender[,-1], balance = balance)
new_student = cbind(student = temp_gender[,-1], balance = balance)
new_marriage = cbind(marriage = temp_gender[,-1], balance = balance)
new_ethnicity = cbind(africanamerican = (temp_ethnicity[,2]+temp_ethnicity[,3]-1)*(-1)
                      , asian = temp_ethnicity[,2], caucasian = temp_ethnicity[,3], balance = balance)

#saving dummyout variables
new_credit = data.frame(income, limit, rating, cards, age, education, gender = new_gender[,1], student = new_student[,1]
                      , marriage=new_marriage[,1], africanamerican = new_ethnicity[,1]
                      , asian = new_ethnicity[,2], caucasian = new_ethnicity[,3] 
                      , balance = balance)
write.csv(new_credit, file ="../../data/new-credit.csv" )



#Mean Centering and Standardizing 
scaled_credit = scale(new_credit, center=TRUE, scale=TRUE)
write.csv(scaled_credit, file = "../../data/scaled-credit.csv")
