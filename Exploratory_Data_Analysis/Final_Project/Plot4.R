library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC$SCC <- as.character(SCC$SCC)

both.SCC <- intersect(SCC$SCC,NEI$SCC)
SCC <- SCC[SCC$SCC %in% both.SCC,]

coal <- grep("[Cc]oal",SCC$Short.Name)

index <- SCC[coal,]$SCC

NEI <- NEI[NEI$SCC %in% index,]


years <- NEI$year
total <- NEI$Emissions


totalBaltimore <- group_by(data.frame(years,total), years)

totalBaltimore <- summarise(totalBaltimore, emission = sum(total))

ggplot(totalBaltimore, aes(years, emission, col = years)) + 
        geom_point() + geom_line() + ylab("Amount of PM 2.5 in tons") +
        xlab("Years") + ggtitle("PM 2.5 emited by coal combustion")


ggsave("Plot4.png")