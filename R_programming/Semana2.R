# Programing Assignment 
# Week 2
# R Programming
# Data science by Johns Hopkings University
# Coursera 


download_path <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
namezip <- "pollution_monitoring.zip"
download.file(download_path)

pollutantmean <- function (directory,pollutant, id= 1:332) {
    path <- getwd()
    path <- paste(path,directory,sep = "/")
    means <- c()
    for (i in id){
      n <- as.character(i)
      if (i < 100){
        n <- paste('0',n,sep = '')
      }
      if (i < 10){
        n <- paste('0',n,sep = '')
      }
        path_file <- paste(path, "/", n,".csv", sep = "")
        data <- read.csv(path_file)
        data2 <- data[pollutant]
        trues <- !is.na(data2)
        this_mean <- (data2[trues])
        means <- c(means,this_mean)
    }
    mean(means)
}


complete <- function(directory, id = 1:332){
  path <- getwd()
  path <- paste(path,directory,sep = "/")
  nobs <- c()
  id2 <- c()
  for (i in id){
    n <- as.character(i)
    if (i < 100){
      n <- paste('0',n,sep = '')
    }
    if (i < 10){
      n <- paste('0',n,sep = '')
    }
    path_file <- paste(path, "/", n,".csv", sep = "")
    data <- read.csv(path_file)
    good <- complete.cases(data)
    nobs <- c(nobs,dim(data[good,])[1])
    id2 <- c(id2,i)
  }
  id <- id2
  salida <- data.frame(id,nobs)
  salida
}


corr <- function(directory, thereshold = 0){
  path <- getwd()
  path <- paste(path,directory,sep = "/")
  complete <- complete(directory)
  cor_vect <- c()
  for (i in 1:dim(complete)[1]){
    if (complete[,2][i] > thereshold){
      n <- i
      if (i < 100){
        n <- paste('0', n, sep = '')
      }
      if (i < 10){
        n <- paste('0', n, sep = '')
      }
      path_file <- paste(path, "/", n,".csv", sep = "")
      data <- read.csv(path_file)
      good <- complete.cases(data)
      data <- data[good,]
      cor_vect <- c(cor_vect, cor(data$sulfate,data$nitrate))
    }
  }
  cor_vect
}


cr <- corr("specdata")

complete("specdata")

pollutantmean("specdata","nitrate")

