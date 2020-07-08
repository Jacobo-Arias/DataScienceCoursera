datos <- read.csv("hw1_data.csv")
length(datos[,1])
head(datos)
names(datos)
datos[1:2,]
length(datos[,1])
datos[152:153,]
datos[47,"Ozone"]

summary(datos$Ozone)

good <- complete.cases(datos)

mean(datos$Ozone[good])
mean(datos["Ozone"])
a <- subset(datos,datos$Ozone > 31 & datos$Temp > 90)
mean(a$So)

mean(subset(datos,datos$Month == 6)$Temp)

sort(subset(datos,datos$Month == 5)$Ozone,TRUE)
