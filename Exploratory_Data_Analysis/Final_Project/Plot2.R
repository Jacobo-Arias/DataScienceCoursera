library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI %>% subset(fips == "24510")

years <- NEI$year
total <- NEI$Emissions

totalBaltimore <- group_by(data.frame(years,total), years)

totalBaltimore <- summarise(totalBaltimore, emission = sum(total))

plot(totalNei, type = 'b', col = "red4",
     main = "PM 2.5 emmisions in Baltimore",
     xlab = "Years", ylab = "Amount of PM2.5 emitted, in tons")

dev.copy(png, "Plot2.png")
dev.off()