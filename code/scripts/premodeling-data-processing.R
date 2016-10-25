getwd()
setwd('pandoc-test/Stat159/stat159-fall2016-project2')

credit <- read.csv('data/credit.csv')
temp_gender <- model.matrix(Gender~., data = credit)
temp_student <- model.matrix(Student~., data = credit)
temp_married <- model.matrix(Married~., data = credit)
temp_ethnicity <- model.matrix(Ethnicity~., data=credit)


#right now, the function works WITHOUT the Balance=Balance part. but the instructions call for it.
new_gender <- cbind(temp_gender[ ,-1], Balance= Balance)
new_student <- cbind(temp_student[ ,-1], Balance= Balance)
new_married <- cbind(temp_married[ ,-1], Balance=Balance)
new_ethnicity <- cbind(temp_ethnicity[ ,-1], Balance=Balance)

#i used these (below) in creating the scaled_ csv files
#new_gender <- cbind(temp_gender[ ,-1])
#new_student <- cbind(temp_student[ ,-1])
#new_married <- cbind(temp_married[ ,-1])
#new_ethnicity <- cbind(temp_ethnicity[ ,-1])



#this is standardizing all of the variables to have mean=0 ; sd=1
scaled_gender <- scale(new_gender, center = TRUE, scale = TRUE)
write.csv(scaled_gender, file = "data/scaled-gender.csv")

scaled_student <- scale(new_student, center = TRUE, scale = TRUE)
write.csv(scaled_student, file = "data/scaled-student.csv")

scaled_married <- scale(new_married, center = TRUE, scale = TRUE)
write.csv(scaled_married, file = "data/scaled-married.csv")

scaled_ethnicity <- scale(new_ethnicity, center = TRUE, scale = TRUE)
write.csv(scaled_ethnicity, file = "data/scaled-ethnicity.csv")
