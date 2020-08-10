library(dplyr)

#load data from test an merge in a data set
test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

test <- data.frame(subject_test, test.y, test.x)

#load data from train an merge in a data set
train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

train <- data.frame(subject_train, train.y, train.x)

#merge both data in a single data.set
totalData <- rbind(test,train)

#clean the data that is not necesary
rm(test.x, test.y, subject_test, subject_train, train.x, train.y, test, train)

#load labes and features
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#rename de columns with the appropiate name
colnames(totalData) <- c("Subject", "Activity", as.character(features$V2))

#extract the labels in a single vector
labels <- labels$V2

#change the values of Activity to the respective name
for (variable in 1:6) {
       totalData$Activity[totalData$Activity == variable] <- as.character(labels[variable])
}

#clean the data that is not necesary
rm(labels, variable, features)

#select only the columns that contain "mean()" and "std()"
totalData <- select(totalData, c(Subject, Activity, contains(c("mean()","std()"))))

#Group data by cols subject and Activity and then find the mean of each
DataSummary <- totalData %>% group_by(Subject, Activity) %>% summarise_each(mean)

#save the tidy data
write.table(DataSummary, file = "run_data_summary.txt")
