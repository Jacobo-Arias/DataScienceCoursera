library(lubridate)
library(dplyr)

data <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
data$Date <- dmy((data$Date))

dates <- c(ymd("2007-02-01", ymd("2007-02-02")))

data <- data %>% filter(Date == dates[1] | Date == dates[2])

hist(as.numeric(data$Global_active_power), col = "red", breaks = 6)

dev.copy(png, "plot1.png")

dev.off()