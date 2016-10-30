new_credit = read.csv("../../data/new-credit.csv")
scaled_credit = read.csv("../../data/scaled-credit.RData")

set.seed(0)
sub = sample(1:400, 300, replace = FALSE)

<<<<<<< HEAD
new_credit_train = new_credit[sub,]
new_credit_test = new_credit[-sub,]
=======
save(test,train, file = "../../data/train-test.Rdata")
new_credit_test = new_credit[sub,]
new_credit_train = new_credit[-sub,]
>>>>>>> 54b604550766bc9571e8309ac4ac34c7a590fd4f

scaled_credit_train = scaled_credit[sub,]
scaled_credit_test = scaled_credit[-sub,]

save(new_credit_test, new_credit_train, file = "../../data/new-train-test.Rdata")
save(scaled_credit_test, scaled_credit_train, file = "../../data/scale-train-test.RData")
<<<<<<< HEAD
=======

>>>>>>> 54b604550766bc9571e8309ac4ac34c7a590fd4f
