run_analysis <- function() {
  
  ## loading needed libraries
  library(dplyr)
  library(stringr)
  library(reshape2)
  
  
  ## loading raw data for test and train sets
  trainRaw <- read.table("UCI HAR Dataset\\train\\X_train.txt", header = FALSE)
  testRaw  <- read.table("UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
  
  ## loading column names
  names <- read.table("UCI HAR Dataset\\features.txt", header = FALSE) 
  names <- names[,2]
  
  ## generating easily-readable names
  names <- str_replace_all(names, "\\(\\)", "")
  names <- str_replace_all(names, "-", ".")
  
  ## asigning names to raw-data columns
  names(trainRaw) <- names
  names(testRaw) <- names
  
  ## filtering out only columns with 'mean' and 'std' substrings and asigning them to subsets
  selectedColumns <- c(grep("mean", names, fixed = TRUE), grep("std", names, fixed = TRUE))
  selectedColumns <- sort(selectedColumns)
  trainRaw <- trainRaw[, selectedColumns]
  testRaw <- testRaw[, selectedColumns]
  
  ## loading test and train activities information
  trainActivities <- read.table("UCI HAR Dataset\\train\\y_train.txt", header = FALSE)
  testActivities  <- read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE)
  
  ## loading test and train subjects information
  trainSubjects <- read.table("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)
  testSubjects  <- read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)
  
  ## combining those columns with raw data for test and train sets; renaming new columns
  train <- cbind(trainSubjects, trainActivities, trainRaw)
  test <- cbind(testSubjects, testActivities, testRaw)
  colnames(train)[1] <- "Subject"
  colnames(test)[1] <- "Subject"
  colnames(train)[2] <- "Activity"
  colnames(test)[2] <- "Activity"
  
  ## merging test and train sets
  fullSet = rbind(train, test)
  
  ## loading factor labels for activities; factorising 'Activity' column 
  activityLabels <- read.table("UCI HAR Dataset\\activity_labels.txt", header = FALSE) 
  fullSet$Activity <- factor(fullSet$Activity, labels = activityLabels[, 2])
  
  ## generating narrow output: melting, grouping and summarising data
  meltedData <- melt(fullSet, id.vars=c("Subject", "Activity"),
                     measure.vars=c(3:81), variable.name="Variable", value.name="Value")
  groupedMeltedData <- group_by(meltedData, Subject, Activity, Variable)
  summary <- summarise(groupedMeltedData, Mean=mean(Value))
  
  ## writing output
  write.table(summary, "summary.txt", row.name = FALSE)
  summary
}