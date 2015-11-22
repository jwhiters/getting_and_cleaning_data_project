### Getting and Cleaning Data - Course Project
### Jonathan Whiters
### November 21, 2015

# runAnalysis.r File Description

# This script will perform the following steps on the UCI HAR dataset collected from accelerometers (total acceleration) on Samsung Galaxy S II smartphones.

# 1. Merge the training and test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activites in the data set.
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

#################

# Clean up R Studio workspace

rm(list = ls())

# 1. Merge the training and the test sets to create one data set.

# Set working directory to the location where UCI HAR Dataset was unzipped

setwd('/Users/Owner/Desktop/UCI HAR Dataset/')

# Read the data from files

features <- read.table('./features.txt',header = FALSE)
activityType <- read.table('./activity_labels.txt',header = FALSE)
subjectTrain <- read.table('./train/subject_train.txt',header = FALSE)
xTrain <- read.table('./train/x_train.txt',header = FALSE)
yTrain <- read.table('./train/y_train.txt',header = FALSE)

# Assign column names to the data imported above

colnames(activityType) <- c('activityId','activityType')
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"

# Create the final training set by merging subjectTrain, xTrain, and yTrain

trainingData <- cbind(xTrain,yTrain,subjectTrain)

# Read in the test data

subjectTest <- read.table('./test/subject_test.txt',header = FALSE)
xTest <- read.table('./test/x_test.txt',header = FALSE)
yTest <- read.table('./test/y_test.txt',header = FALSE)

# Assign column names to the test data imported above

colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

# Create the final test set by merging the xTest, yTest and subjectTest data

testData <- cbind(xTest,yTest,subjectTest)

# Combine training and test data to create a final data set

finalData <- rbind(trainingData,testData)

# Create a vector for the column names from the finalData, which will be used to select
# the desired mean() and stddev() columns

colNames <- colnames(finalData)

# 2. Extract only the measurements on the mean and standard deviation for the measurement

#Create a logicalVector that contains TRUE values for the ID, mean(), and stddev() columns and FALSE for others

logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames))

# Subset finalData table based on the logicalVector to keep only desired columns

finalData <- finalData[logicalVector==TRUE]

# 3. use descriptive activity names to name the activities in the data set.

# Merge the finalData set with the activityType table to include descriptive activity names

finalData <- merge(finalData,activityType,by='activityId',all.x=TRUE)

#Updating the colNames vector to include new column names after merge

colNames <- colnames(finalData)

# 4. Appropriately label the data set with descriptive activity names.

for (i in 1:length(colNames))
{
    colNames[i] <- gsub("\\()","",colNames[i])
    colNames[i] <- gsub("-std$", "StdDev",colNames[i])
    colNames[i] <- gsub("-mean","Mean",colNames[i])
    colNames[i] <- gsub("^(t)","time",colNames[i])
    colNames[i] <- gsub("^(f)","freq",colNames[i])
    colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] <- gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}

# Reassigning the new descriptive column names to the finalData set

colnames(finalData) <- colNames

# 5. Create a second independent tidy data set with the average(mean) of each variable for each activity and each subject.

# Create a new table, finalDataNoActivityType without the activityType column

finalDataNoActivityType <- finalData[,names(finalData) != 'activityType']

# Summarize the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject

tidyData <- aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) !=c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean)

# Merge the tidyData with activityType to include descriptive activity names

tidyData <- merge(tidyData,activityType,by='activityId',all.x=TRUE)

# Export the tidyData set

write.table(tidyData, './tidyData.txt',row.names = FALSE, sep = '\t')