#Best Hospital
#1  Plot the 30-day mortality rates for heart attack


datos <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
datos[,11] <- as.numeric(datos[, 11])
datos[,17] <- as.numeric(datos[, 17])
datos[,23] <- as.numeric(datos[, 23])

best <- function(state, outcome){
        x <- rankhospital(state,outcome)
        x
}
best('TX','heart failure')

#Rank Hospital
#2  Ranking hospitals by outcome in a state


rankhospital <- function(state, outcome, rank = 'best'){
        outcome2 <- tolower(outcome)
        states <- unique(datos$State)
        names <- c('heart attack', 'heart failure', 'pneumonia')
        if (!(states[states == state] == state))
        {
          return(print(paste("Error in best(",state,", ",outcome,") : invalid state", sep = '')))
        }
        if (!(names[names == outcome2] == outcome2)) 
        {
          return(print(paste("Error in best(",state,", ",outcome,") : invalid outcome", sep = '')))
        }
        
        dataH <- subset(datos, datos$State == state)
        Hospital_Name <- dataH$Hospital.Name
        Heart_Attack <- dataH[,11]
        Heart_Failure <- dataH[,17]
        Pneumonia <- dataH[,23]
        dataH <- data.frame(Hospital_Name, Heart_Attack, Heart_Failure, Pneumonia)
        
        if (outcome2 == "heart attack") {ordered <- dataH[order(Heart_Attack,Hospital_Name),]}
        if (outcome2 == "heart failure") {ordered <- dataH[order(Heart_Failure,Hospital_Name),]}
        if (outcome2 == "pneumonia") {ordered <- dataH[order(Pneumonia,Hospital_Name),]}
        
        
        if (rank == 'worst') { rank <- length(dataH$Heart_Failure)}
        if (rank == 'best') {rank <- 1}
      
        x <- ordered$Hospital_Name[rank]
        x
        
}

rankhospital("MD", "heart attack", "worst")
rankhospital("TX", "heart failure")

# Rank all
# Ranking hospitals in all states
rankall <- function(outcome, num = "best"){
        outcome2 <- tolower(outcome)
        states <- unique(datos$State)
        names <- c('heart attack', 'heart failure', 'pneumonia')
        if (!(names[names == outcome2] == outcome2)) 
        {
          return(print(paste("Error in best(",state,", ",outcome,") : invalid outcome", sep = '')))
        }
  
        if (num == 'worst') { num <- nrow(ordered)}
        if (num == 'best') {num <- 1}
        
        todo <- split(datos, datos$State)
        Hospital_name <- c()
        
        for (state in states) {
              dataH <- subset(datos, datos$State == state)
              Hospital_Name <- dataH$Hospital.Name
              Heart_Attack <- dataH[,11]
              Heart_Failure <- dataH[,17]
              Pneumonia <- dataH[,23]
              dataH <- data.frame(Hospital_Name, Heart_Attack, Heart_Failure, Pneumonia)
              
              if (outcome2 == "heart attack") {ordered <- dataH[order(Heart_Attack,Hospital_Name),]}
              if (outcome2 == "heart failure") {ordered <- dataH[order(Heart_Failure,Hospital_Name),]}
              if (outcome2 == "pneumonia") {ordered <- dataH[order(Pneumonia,Hospital_Name),]}
              
              x <- as.character(ordered$Hospital_Name[num])
              Hospital_name <- c(Hospital_name, x)
          
        }
        data.frame(Hospital_name,states)[order(states),]
}

rankall("heart attack",20)

esto <- split(datos, datos$State)
esto["TX"]
names(datos)
