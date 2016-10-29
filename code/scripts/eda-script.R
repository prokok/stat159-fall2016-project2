#Loading, Clean Data for eda-analysis"
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

#EDA-Analysis: eda-output.txt"
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


#Creating Histograms for Quantative Variable
for(i in 1:length(quant))
{
  path1 = paste("../../images/histogram-",names(quant[i]),".png")
  png(filename = path1, width=800, height=600)
  hist(as.vector(unlist(quant[i])) ,breaks= 10, main = paste("Histogram of "
          ,names(quant[i])), col = "#5679DF", xlab = paste(names(quant[i])))
  dev.off()
}


#Creating Scatterplotmatrix
png("../../images/scatterplot-matrix.png", width=800, height=600)
pairs(~income+limit+rating+cards+age+education+balance,data=quant, main="Scatterplot matrix among quantative variables")
dev.off()



#Creating barcharts for Qualitative Variable
for(i in 1:length(qual))
{
  path2 = paste("../../images/barchart-",names(qual[i]),".png")
  png(filename = path2, width=800, height=600)
  barplot(prop.table(table(qual[i])), col = "#5679DF", main = paste("Barchart of ", names(qual[i])))
  dev.off()
}


#anova's between Balance and all the qualitative variables (gender, student, marriage, ethnicity)
anova_gender = aov(balance~gender)
anova_student = aov(balance~student)
anova_marriage = aov(balance~marriage)
anova_ethnicity = aov(balance~ethnicity)
save(anova_gender, anova_student, anova_marriage, anova_ethnicity, file = "../../data/anova-qual.RData")

#appending anova anaylsis to eda-output.txt
sink(file = "../../data/eda-output.txt", append = TRUE)
cat("3. Anova Analysis on Qualative Variable\n\n")
cat("Anova Analysis of gender on balance\n\n")
summary(anova_gender)
cat("\n")
cat("Anova Analysis of student on balance\n\n")
summary(anova_student)
cat("\n")
cat("Anova Analysis of marriage on balance\n\n")
summary(anova_marriage)
cat("\n")
cat("Anova Analysis of ethnicity on balance\n\n")
summary(anova_ethnicity)
cat("\n")
sink()


#Creating conditional boxplots between Balance and the qualitative variables (gender, student, marriage, ethnicity)
for(i in 1:length(qual))
{
  path3 = paste("../../images/conditional-boxplot-balance-",names(qual[i]),".png")
  png(filename = path3, width=800, height=600)
  plot(x=qual[i],y=balance, col = "#5679DF"
       , main = paste("Condition boxplot of ", names(qual[i])," on Balance"))
  dev.off()
}


