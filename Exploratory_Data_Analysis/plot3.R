library(lubridate)
library(dplyr)

data <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
data$Date <- dmy((data$Date))
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

dates <- c(ymd("2007-02-01", ymd("2007-02-02")))

data <- data %>% filter(Date == dates[1] | Date == dates[2])

plot(data$Sub_metering_1, type = 'l', axes = FALSE,
     ylab = "Energy sub metering", xlab = '')

lines(data$Sub_metering_2, type = 'l', col = "red")
lines(data$Sub_metering_3, type = 'l', col = "blue")

axis(1, at = c(0, 1400, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2,at = c(0, 10, 20, 30), labels = c(0, 10, 20, 30))
box()

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1, col = c("black", "red", "blue"))

dev.copy(png, "plot3.png")
dev.off()
