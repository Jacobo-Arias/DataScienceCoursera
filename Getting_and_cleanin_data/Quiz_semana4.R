# Pregunta 1

data <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

n <-names(data)

strsplit(n, "wgtp")[[123]]


# Pregunta 2

library(dplyr)
data2 <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")

GDP <- data2 %>% mutate(ranking = as.numeric(as.character(Gross.domestic.product.2012))) %>% 
        select(-(Gross.domestic.product.2012:X.1)) %>% select(-(X.4:X.8)) %>%
        filter(!is.na(ranking)) %>% rename(Country = X.2, Millions = X.3, ID = X)

millions <- gsub(",","",GDP$Millions)
mean(as.numeric(as.character(millions)))

# Pregunta 3

grep("^United", data2$Country)


# Pregunta 4

GDP <- GDP

Educational <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

DataJoined <- merge(x = GDP, y = Educational, by.x = "ID", by.y = "CountryCode")

table(grepl("^Fiscal year end: June", DataJoined$Special.Notes))

#Pregunta 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
str(amzn)
library(lubridate)
table(year(sampleTimes) == 2012)

table(wday(sampleTimes, label = T) == "lun" & year(sampleTimes) == 2012)

