
### 1. Setup

# Packages
library("plyr")

# file paths - test sample
fpath_test <- "UCI HAR Dataset/test/X_test.txt"
fpath_testAct <- "UCI HAR Dataset/test/y_test.txt"
fpath_testSubj <- "UCI HAR Dataset/test/subject_test.txt"

# file paths - training sample
fpath_train <- "UCI HAR Dataset/train/X_train.txt"
fpath_trainAct <- "UCI HAR Dataset/train/y_train.txt"
fpath_trainSubj <- "UCI HAR Dataset/train/subject_train.txt"

# file paths - features and acitivies
fpath_features <- "UCI HAR Dataset/features.txt"
fpath_activity <- "UCI HAR Dataset/activity_labels.txt"

# read in files
test <- read.table(file=fpath_test)
testAct <- read.table(file=fpath_testAct)
testSubj <- read.table(file=fpath_testSubj)

train <- read.table(file=fpath_train)
trainAct <- read.table(file=fpath_trainAct)
trainSubj <- read.table(file=fpath_trainSubj)

features <- read.table(file=fpath_features)
activity <- read.table(file=fpath_activity)
colnames(activity) <- c("actvNum", "Activity")

### Attach activity an subject data to train and test data
test2 <- cbind(testSubj, testAct, test)
train2 <- cbind(trainSubj, trainAct, train)

# Read in column names from features data frame
columnNames <- as.character(features[,2])

# apply column names to test and train
colnames(test2) <- c("Subject","actvNum",columnNames)
colnames(train2) <- c("Subject","actvNum",columnNames)

### 2. Combine test and train data
combined <- rbind(test2, train2)

### 3. Keep only mean and std chars (plus ID's)

# creates a logical vector containig TRUE if the char
# is mean(), std(), actvNum, or Subject, and FALSE otherwise
keepChars <- grepl("mean\\(\\)", colnames(combined)) | 
    grepl("std\\(\\)", colnames(combined)) |
    grepl("actvNum", colnames(combined)) |
    grepl("Subject", colnames(combined))

# uses logical vector to keep only required chars
reducedData <- combined[,keepChars]

### 4. Rename chars (Example code was taken from the web)
names(reducedData)<-gsub("^t", "time", names(reducedData))
names(reducedData)<-gsub("^f", "frequency", names(reducedData))
names(reducedData)<-gsub("Acc", "Accelerometer", names(reducedData))
names(reducedData)<-gsub("Gyro", "Gyroscope", names(reducedData))
names(reducedData)<-gsub("Mag", "Magnitude", names(reducedData))
names(reducedData)<-gsub("BodyBody", "Body", names(reducedData))

### 5. Create Activity variable from activity data frame
tidyData <- merge(reducedData, activity, by="actvNum")
# remove actvNum variable
tidyData[,"actvNum"] <- NULL
#Order data
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]


### 6. create summary data
# aggregate everything by activity and subject
summaryData <- aggregate(. ~ Activity + Subject,
                        tidyData, mean)

write.table(summaryData, file="tidydata.txt", row.name=FALSE)
