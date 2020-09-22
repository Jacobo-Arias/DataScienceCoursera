library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC$SCC <- as.character(SCC$SCC)
NEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]
both.SCC <- intersect(SCC$SCC,NEI$SCC)
SCC <- SCC[SCC$SCC %in% both.SCC,]

vehicle <- grep("Motor|Vehicle",SCC$Short.Name)
index <- SCC[vehicle,]$SCC

NEI <- NEI[NEI$SCC %in% index,]


years <- NEI$year
total <- NEI$Emissions


totalBaltimore <- group_by(data.frame(years,total), years)

totalBaltimore <- summarise(totalBaltimore, emission = sum(total))

ggplot(totalBaltimore, aes(years, emission,)) + 
        geom_point(col = "red") + geom_line(col = "red") + ylab("Amount of PM 2.5 in tons") +
        xlab("Years") + ggtitle("PM 2.5 emited by motor vehicle")


ggsave("Plot5.png")