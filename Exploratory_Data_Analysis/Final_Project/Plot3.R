library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI %>% subset(fips == "24510")

years <- NEI$year
total <- NEI$Emissions
type <- NEI$type


totalBaltimore <- group_by(data.frame(years,type,total), years, type)

totalBaltimore <- summarise(totalBaltimore, emission = sum(total))

ggplot(totalBaltimore, aes(years, emission, col = type)) + 
        geom_point() + geom_line() + ylab("Amount of PM 2.5 emitted, in tons") +
        xlab("Years") + ggtitle("PM 2.5 in Baltimore")


ggsave("Plot3.png")