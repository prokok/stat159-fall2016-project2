new_credit = read.csv("../../data/new-credit.csv")
scaled_credit = read.csv("../../data/scaled-credit.csv")
new_credit = new_credit[,-1]
scaled_credit = scaled_credit[,-1]

set.seed(0)
sub = sample(1:400, 300, replace = FALSE)

new_credit_train = new_credit[sub,]
new_credit_test = new_credit[-sub,]

scaled_credit_train = scaled_credit[sub,]
scaled_credit_test = scaled_credit[-sub,]

save(new_credit_test, new_credit_train, file = "../../data/new-train-test.Rdata")
save(scaled_credit_test, scaled_credit_train, file = "../../data/scale-train-test.RData")

