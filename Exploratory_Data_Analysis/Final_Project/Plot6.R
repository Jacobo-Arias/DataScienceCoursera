library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC$SCC <- as.character(SCC$SCC)
NEI <- NEI[NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD",]

both.SCC <- intersect(SCC$SCC,NEI$SCC)
SCC <- SCC[SCC$SCC %in% both.SCC,]

vehicle <- grep("Motor|Vehicle",SCC$Short.Name)
index <- SCC[vehicle,]$SCC

NEI <- NEI[NEI$SCC %in% index,]

Year <- NEI$year
total <- NEI$Emissions
City <- NEI$fips


totalBaltimore <- group_by(data.frame(Year,total,City), Year, City)
totalBaltimore <- summarise(totalBaltimore, emission = sum(total))
totalBaltimore$City <- sub("06037", "Los Angeles", totalBaltimore$City)
totalBaltimore$City <- sub("24510", "Baltimore", totalBaltimore$City)

ggplot(totalBaltimore, aes(Year, emission, col = City)) + 
        geom_point() + geom_line() + ylab("Amount of PM 2.5 in tons") +
        xlab("Year") + ggtitle("PM 2.5 emited by motor vehicle")


ggsave("Plot6.png")