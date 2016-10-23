dat <- read.csv('../../data/Advertising.csv', row.names = 1)  
sum_tv = summary(dat$TV)
sum_radio = summary(dat$Radio)
sum_news = summary(dat$Newspaper)
sum_sale = summary(dat$Sales)

corr_frame = data.frame(TV = dat$TV, radio = dat$Radio, newspaper = dat$Newspaper, sales = dat$Sales)
corr_matrix = cor(corr_frame)

save(corr_matrix, file = "../../data/correlation-matrix.RData")

upper_corr_matrix = format(corr_matrix, digits = 4)
upper_corr_matrix[lower.tri(upper_corr_matrix, diag=FALSE)] = ""

sink(file = "../../data/eda-output.txt")
cat("summary statistics of TV\n\n")
sum_tv
cat("\n")
cat("summary statistics of Radio\n\n")
sum_radio
cat("\n")
cat("summary statistics of Newspaper\n\n")
sum_news
cat("\n")
cat("summary statistics of Sales\n\n")
sum_sale
cat("\n")
cat("\n")
cat("Correlation matrix for TV, radio, newspaper, and sales for the Advertising data.\n\n")
print(as.data.frame(upper_corr_matrix))
sink()


png("../../images/histogram-tv.png", width=800, height=600)
hist(dat$TV, ylim = c(0,40), col = "#5679DF"
     , main = "Histogram of TV advertising budget", breaks=15, xlab = "TV advertising budget (in thousands of dollars)")
dev.off()


png("../../images/histogram-radio.png", width=800, height=600)
hist(dat$Radio, ylim = c(0,40), col = "#5679DF"
     , main = "Histogram of radio advertising budget", breaks=15, xlab = "radio advertising budget (in thousands of dollars)")
dev.off()


png("../../images/histogram-newspaper.png", width=800, height=600)
hist(dat$Newspaper, ylim = c(0,50), col = "#5679DF"
     , main = "Histogram of newspaper advertising budget", breaks=15, xlab = "newspaper advertising budget (in thousands of dollars)")
dev.off()


png("../../images/histogram-sales.png", width=800, height=600)
hist(dat$Sales, ylim = c(0,50), col = "#5679DF"
     , main = "Histogram of sales", breaks=15, xlab = "sales (in thousands of dollars)")
dev.off()


png("../../images/scatterplot-matrix.png", width=800, height=600)
pairs(~TV+Radio+Newspaper+Sales,data=dat, main="Scatterplot matrix among TV, Radio, Newpaper, Sales")
dev.off()

