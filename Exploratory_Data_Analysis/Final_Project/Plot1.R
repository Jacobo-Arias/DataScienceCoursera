library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

years <- NEI$year
total <- NEI$Emissions

totalNEI <- group_by(data.frame(years,total), years)

totalNei <- summarise(totalNEI, emission = sum(total))

plot(totalNei, type = 'b', col = "skyblue4",
     main = "PM 2.5 emmisions per year beetwen 1999 and 2008",
     xlab = "Years", ylab = "Amount of PM2.5 emitted, in tons")

dev.copy(png, "Plot1.png")
dev.off()