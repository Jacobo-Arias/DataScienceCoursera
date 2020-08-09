# Question 1

library(dplyr)

data <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
View(data)
data$AGS
agricultureLogical <-  data$ACR == 3 & data$AGS == 6

which(agricultureLogical)

install.packages("jpeg")

# Question 2

library(jpeg)
foto <- readJPEG("getdata_jeff.jpeg", native = TRUE)
(foto)
a <- quantile(foto, probs = c(0.3, 0.8))[1]

#Question 3

GDP_Data <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
Educational <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

Domestic <- GDP_Data %>% 
        select(-(X.4:X.8),-X.1) %>% 
        mutate(Gross.domestic.product.2012 = as.numeric(as.character(Gross.domestic.product.2012))) %>%
        filter(!is.na(Gross.domestic.product.2012))


total <- merge(Domestic, Educational, by.x = "X", by.y = "CountryCode")

total_sorted <- total %>% arrange(desc(Gross.domestic.product.2012))
head(total_sorted, n=13)

#Question 4

total_grouped <- total %>% group_by(Income.Group)

summarise(total_grouped, meanIncome = mean(Gross.domestic.product.2012, na.rm = T))


#Question 5
qtl <- quantile(total$Gross.domestic.product.2012, probs = seq(0,1,0.2), na.rm = T);qtl
table(cut(total$Gross.domestic.product.2012,qtl))
totalLowMiddle <- total %>% filter(Income.Group == "Lower middle income")
