# this is not needed but will clear out old variables
rm(list=ls())

# Load Libraries
library(dplyr)

#Prepare to download file
dataFileZip <- "Getting_and_Cleaning_Data.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Check for/make sub-directory "coursera"  
mainDir <- "C:"
subDir <- "coursera"
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

# Check for/make sub-directory "GetAndCleanData"  
mainDir <- paste(mainDir, "/", subDir,sep="")
subDir <- "GetAndCleanData"
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

# Check for/make sub-directory "final"  
mainDir <- paste(mainDir, "/", subDir,sep="")
subDir <- "final"
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

# Check if file exists downlaod.
mainDir <- paste(mainDir, "/", subDir,sep="")
filename <- paste(mainDir, "/", dataFileZip,sep="")

if (!file.exists(filename)){
  download.file(url, filename, method="curl")
}  


# unzip 
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Remove unneeded variables
rm(list="dataFileZip","url","mainDir","subDir","filename")


# read files
activities_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("type", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("FeatRow","feature"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "type")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "type")

# bind related tables by row and remove old tables
x_table <- rbind(x_test, x_train)
y_table <- rbind(y_test, y_train)
subject_table <- rbind(subject_test, subject_train)
rm(list="x_test","x_train","y_test","y_train","subject_test","subject_train","features")

# Merge all data by column and remove old tables
merged_data <- cbind(subject_table,x_table,y_table)
rm(list="subject_table","x_table","y_table")

# Keep only necessary columns and remove old tables
cleaner_data <- merged_data %>% select(Subject, type, contains("mean"), contains("std"))
rm(list="merged_data")


# Replace type with Activity
cleaner_data$type <- activities_labels[cleaner_data$type, 2]
rm(list="activities_labels")

# make the headers readable
names(cleaner_data) <- gsub("type", "Activity", names(cleaner_data))
names(cleaner_data) <- gsub("Acc", "Accelerometer", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub("tBody", "TimeBody", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub("fBody", "FrequencyBody", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub("Gyro", "Gyroscope", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub("BodyBody", "Body", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub("Mag", "Magnitude", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub(".mean()", "Mean", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub(".std()", "STD", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub(".freq()", "Frequency", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub("angle", "Angle", names(cleaner_data), ignore.case = TRUE)
names(cleaner_data) <- gsub("gravity", "Gravity", names(cleaner_data), ignore.case = TRUE)

# Rename table
tidy_data <- cleaner_data
rm(list="cleaner_data")

# Create summary table 
data_Summary <- tidy_data %>% group_by(Subject, Activity) %>% summarise_all(list(mean))