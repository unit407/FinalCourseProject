library(reshape2)

## Set working directory
setwd("/Users/RyanKramer/Desktop/Coursera/UCI Har Dataset/")

# Loading activity labels
actlabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
actlabels[, 2] <- as.character(labels[, 2])

features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
features[, 2] <- as.character(features[, 2])

# Pull out mean and standard deviation
featuresNeeded <- grep(".*mean.*|.*std.*", features[, 2])
featuresNeeded.names <- features[featuresNeeded, 2]
featuresNeeded.names = gsub('-mean', 'Mean', featuresNeeded.names)
featuresNeeded.names = gsub('-std', 'Std', featuresNeeded.names)
featuresNeeded.names <- gsub('[-()]', '', featuresNeeded.names)


# Load datasets and then merge
train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)[featuresNeeded]
activities <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE)
subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
train <- cbind(subjects, activities, train)

testing <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)[featuresNeeded]
testing_Activities <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE)
testing_Subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testing <- cbind(testing_Subjects, testing_Activities, test)
mergedData <- rbind(train, testing)
colnames(mergedData) <- c("Subject", "Activity", featuresNeeded.names)

# Creation of factors
mergedData$Activity <- factor(mergedData$Activity, levels = actlabels[,1], labels = actlabels[,2])
mergedData$Subject <- as.factor(mergedData$Subject)
mergedData.melted <- melt(mergedData, id = c("Subject", "Activity"))
mergedData.mean <- dcast(mergedData.melted, Subject + Activity ~ variable, mean)

# Create final table
write.table(mergedData.mean, "tidy.txt", quote = FALSE, row.names = FALSE)