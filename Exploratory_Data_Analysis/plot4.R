library(lubridate)
library(dplyr)

data <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
data$Date <- dmy((data$Date))
dates <- c(ymd("2007-02-01", ymd("2007-02-02")))
data <- data %>% filter(Date == dates[1] | Date == dates[2])
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)

par(mfrow = c(2,2))
#plot topleft

plot(as.numeric(data$Global_active_power), type = "l", xlab = "", 
     ylab = "Global Active Power (Kilowats)", axes = FALSE)

box()
axis(1, at = c(0, 1400, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2,at = c(0, 2, 4, 6), labels = c(0, 2, 4, 6))

#plot topright

plot(as.numeric(data$Voltage), type = "l", xlab = "", 
     ylab = "Voltage", axes = FALSE)

box()
axis(1, at = c(0, 1400, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2)

#plot bottomleft

plot(data$Sub_metering_1, type = 'l', axes = FALSE,
     ylab = "Energy sub metering", xlab = '')

lines(data$Sub_metering_2, type = 'l', col = "red")
lines(data$Sub_metering_3, type = 'l', col = "blue")

axis(1, at = c(0, 1400, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2,at = c(0, 10, 20, 30), labels = c(0, 10, 20, 30))
box()

legend("topright", legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"),
       lwd = 1, col = c("black", "red", "blue"), lty = c(1,1,1))

#plot bottomright

plot(as.numeric(data$Global_reactive_power), type = "l", xlab = "", 
     ylab = "Global Active Power (Kilowats)", axes = FALSE)

box()
axis(1, at = c(0, 1400, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2)

dev.copy(png, "plot4.png")
dev.off()
