dat = read.csv('../../data/credit.csv', row.names = 1)  

set.seed(0)
sub = sample(1:400, 300, replace = FALSE)
test = dat[sub,]
train = dat[-sub,]

save(test,train, file = "../../data/train-test.Rdata")
