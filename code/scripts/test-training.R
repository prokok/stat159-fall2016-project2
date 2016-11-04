scaled_credit = read.csv("../../data/scaled-credit.csv")
scaled_credit = scaled_credit[,-1]

set.seed(0)
sub = sample(1:400, 300, replace = FALSE)

scaled_credit_train = scaled_credit[sub,]
scaled_credit_test = scaled_credit[-sub,]

save(scaled_credit_test, scaled_credit_train, file = "../../data/scale-train-test.RData")

