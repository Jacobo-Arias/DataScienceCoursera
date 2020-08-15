library(lubridate)
library(dplyr)

data <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
data$Date <- dmy((data$Date))

dates <- c(ymd("2007-02-01", ymd("2007-02-02")))

data <- data %>% filter(Date == dates[1] | Date == dates[2])

plot(as.numeric(data$Global_active_power), type = "l", xlab = "", 
     ylab = "Global Active Power (Kilowats)", axes = FALSE)

box()
axis(1, at = c(0, 1400, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2,at = c(0, 2, 4, 6), labels = c(0, 2, 4, 6))

dev.copy(png, "plot2.png")
dev.off()
