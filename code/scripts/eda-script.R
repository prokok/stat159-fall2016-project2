dat = read.csv('../../data/credit.csv', row.names = 1)  

income = dat$Income
limit = dat$Limit
rating = dat$Rating
cards = dat$Cards
age = dat$Age
education = dat$Education
gender = dat$Gender
student = dat$Student
marriage = dat$Married
ethnicity = dat$Ethnicity
balance = dat$Balance

quant = data.frame(income, limit, rating, cards, age, education, balance)
qual = data.frame(gender, student, marriage, ethnicity)

corr_matrix = cor(quant)
save(corr_matrix, file = "../../data/correlation-matrix.RData")
upper_corr_matrix = format(corr_matrix, digits = 4)
upper_corr_matrix[lower.tri(upper_corr_matrix, diag=FALSE)] = ""


sink(file = "../../data/eda-output.txt")
cat("1. Explanatory Analysis of Quantative Varibles\n\n")
for(i in 1:length(quant))
{
  cat("summary statistics of", names(quant[i]), "\n\n")
  cat(summary(quant[i]), "\n")
  cat("Stadard Deviation. : ", sd(as.vector(unlist(quant[i]))),"\n")
  cat("Range. : ", max(quant[i])-min(quant[i])," \n")
  cat("IQR. : ", IQR(as.vector(unlist(quant[i]))),"\n")
  cat("\n")
}
cat("\n")
cat("Correlation matrix for income, limit, rating, cards, age, education, balance.\n\n")
print(as.data.frame(upper_corr_matrix))
cat("\n\n\n")

cat("2. Explantory Analysis of qualitive Variables\n\n")
for(i in 1:length(qual))
{
  cat("frequency table & relative frequency table of", names(qual[i]), "\n\n")
  write.table(table(qual[i]), row.names = FALSE, col.names = FALSE, quote = FALSE)
  cat("\n")
  write.table(prop.table(table(qual[i])), row.names = FALSE, col.names = FALSE, quote = FALSE)
  cat("\n\n")
}
sink()


#png("../../images/histogram-tv.png", width=800, height=600)
#hist(dat$TV, ylim = c(0,40), col = "#5679DF"
#     , main = "Histogram of TV advertising budget", breaks=15, xlab = "TV advertising budget (in thousands of dollars)")
#dev.off()


#png("../../images/histogram-radio.png", width=800, height=600)
#hist(dat$Radio, ylim = c(0,40), col = "#5679DF"
#     , main = "Histogram of radio advertising budget", breaks=15, xlab = "radio advertising budget (in thousands of dollars)")
#dev.off()


#png("../../images/histogram-newspaper.png", width=800, height=600)
#hist(dat$Newspaper, ylim = c(0,50), col = "#5679DF"
#     , main = "Histogram of newspaper advertising budget", breaks=15, xlab = "newspaper advertising budget (in thousands of dollars)")
#dev.off()


#png("../../images/histogram-sales.png", width=800, height=600)
#hist(dat$Sales, ylim = c(0,50), col = "#5679DF"
#     , main = "Histogram of sales", breaks=15, xlab = "sales (in thousands of dollars)")
#dev.off()


#png("../../images/scatterplot-matrix.png", width=800, height=600)
#pairs(~TV+Radio+Newspaper+Sales,data=dat, main="Scatterplot matrix among TV, Radio, Newpaper, Sales")
#dev.off()

