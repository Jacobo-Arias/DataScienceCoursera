test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

test <- data.frame(subject_test, test.y, test.x)

train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

train <- data.frame(subject_train, train.y, train.x)

totalData <- rbind(test,train)

rm(test.x, test.y, subject_test, subject_train, train.x, train.y, test, train)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

colnames(totalData) <- c("Subject", "Activity", as.character(features$V2))

labels <- labels$V2

for (variable in 1:6) {
       totalData$Activity[totalData$Activity == variable] <- as.character(labels[variable])
}

rm(labels, variable, features)

totalData <- select(totalData, c(Subject, Activity, contains(c("mean()","std()"))))

DataSummary <- totalData %>% group_by(Subject, Activity) %>% summarise_each(mean)

write.table(DataSummary, file = "run_data_summary.txt")
