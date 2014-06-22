# Script to create combined and tidy subsets of the University of California Irvine's (UCI's)
# dataset for Human Activity Recognition (HAR) using smartphones.
#
# See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
#
# This script extracts a cloud-based zipped copy of the HAR Dataset and creates two datasets:
#   1. A combined dataset consisting of the mean and standard deviation of 33 variables
#        across 10,299 observations in the training and test datasets by activity and subject_id.
#   2. A tidy dataset consisting of the mean of the variables from the combined dataset
#        summarized by activity and subject_id (180 observations).
# 
# By default, only the tidy dataset is written to a file. Optionally, the combined dataset
# can also be written to a file by uncommented the appropriate lines of code below.
#
# These files can be subsequently read back in using read.csv as shown below to re-create
# the data tables for further analysis.
#
# To prove that the re-created data table(s) is/are identical, use the compare package:
#
# library(compare)
# new_combined_dt <- data.table(read.csv(combined_file, stringsAsFactors = F))
# new_tidy_dt <- data.table(read.csv(tidy_file, stringsAsFactors = F))
# print(compare(data.frame(new_combined_dt),data.frame(combined_dt)))
# print(compare(data.frame(new_tidy_dt),data.frame(tidy_dt)))

library(data.table)
library(reshape2)

# URL of cloud-based zipped copy of UCI HAR Dataset.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download zipfile into the current working directory if not already downloaded.
local_zipfile <- "./getdata-projectfiles-UCI HAR Dataset.zip"
if (!file.exists(local_zipfile)) {
    download.file(url, destfile = local_zipfile, mode = "wb")
}

# Unzip folder to the current working directory if not already unzipped.
unzipped_folder <- "./UCI HAR Dataset"
if (!file.exists(unzipped_folder)) {
    unzip(local_zipfile)
}

# Create data table of activity names in lower case, adding descriptive column name.
activity_labels <- paste(unzipped_folder, "/activity_labels.txt", sep = "")
activity_labels_dt <- data.table(read.table(activity_labels, stringsAsFactors = F))
activity_labels_dt$V1 <- NULL
setnames(activity_labels_dt, 1, "activity")
activity_labels_dt$activity <- tolower(activity_labels_dt$activity)

# Create data table of feature names, eliminating first column, and adding descriptive column name.
features <- paste(unzipped_folder, "/features.txt", sep = "")
features_dt <- data.table(read.table(features, stringsAsFactors = F))
features_dt$V1 <- NULL
setnames(features_dt, 1, "name")

# Determine which feature names identify mean and standard deviation measurements.
keep_features <- grep("^[t|f].*-mean\\(\\)|^[t|f].*-std\\(\\)", features_dt$name)

# Translate row numbers of feature names to keep into column numbers.
keep_columns <- paste("V", keep_features, sep = "")

# Keep only the mean and standard deviation feature names.
features_dt <- features_dt[keep_features,]

# Make feature names more descriptive.
features_dt$name <- sub("BodyBody", "body_", features_dt$name)
features_dt$name <- sub("Body", "body_", features_dt$name)
features_dt$name <- sub("^[t]", "time_", features_dt$name)
features_dt$name <- sub("^[f]", "freq_", features_dt$name)
features_dt$name <- sub("Acc", "accel_", features_dt$name)
features_dt$name <- sub("Gravity", "gravity_", features_dt$name)
features_dt$name <- sub("Jerk", "jerk_", features_dt$name)
features_dt$name <- sub("Gyro", "gyro_", features_dt$name)
features_dt$name <- sub("-mean\\(\\)-X", "xaxis_avg", features_dt$name)
features_dt$name <- sub("-mean\\(\\)-Y", "yaxis_avg", features_dt$name)
features_dt$name <- sub("-mean\\(\\)-Z", "zaxis_avg", features_dt$name)
features_dt$name <- sub("-std\\(\\)-X", "xaxis_stddev", features_dt$name)
features_dt$name <- sub("-std\\(\\)-Y", "yaxis_stddev", features_dt$name)
features_dt$name <- sub("-std\\(\\)-Z","zaxis_stddev",features_dt$name)
features_dt$name <- sub("Mag-mean\\(\\)", "magn_avg", features_dt$name)
features_dt$name <- sub("Mag-std\\(\\)", "magn_stddev", features_dt$name)

# Create data table of subject IDs from training dataset, adding descriptive column name.
train_subject <- paste(unzipped_folder, "/train/subject_train.txt", sep = "")
train_subject_dt <- data.table(read.table(train_subject, stringsAsFactors = F))
setnames(train_subject_dt, 1, "subject_id")

# Create data table of subject IDs from test dataset, adding descriptive column name.
test_subject <- paste(unzipped_folder, "/test/subject_test.txt", sep = "")
test_subject_dt <- data.table(read.table(test_subject, stringsAsFactors = F))
setnames(test_subject_dt, 1, "subject_id")

# Create data table of activity IDs from training dataset, adding descriptive column name,
# and replacing activity IDs with activity names. 
train_labels <- paste(unzipped_folder, "/train/y_train.txt", sep = "")
train_labels_dt <- data.table(read.table(train_labels, stringsAsFactors = F))
setnames(train_labels_dt, 1, "activity")
train_labels_dt$activity <- activity_labels_dt[train_labels_dt$activity,]

# Create data table of activity IDs from test dataset, adding descriptive column name,
# and replacing activity IDs with activity names.
test_labels <- paste(unzipped_folder, "/test/y_test.txt", sep = "")
test_labels_dt <- data.table(read.table(test_labels, stringsAsFactors = F))
setnames(test_labels_dt, 1, "activity")
test_labels_dt$activity <- activity_labels_dt[test_labels_dt$activity,]

# Create data table of training observations, keeping only the previously identified 
# columns with mean and standard deviation measurements, using the descriptive feature names,
# and inserting columns for activity and subject_id).
train_set <- paste(unzipped_folder, "/train/X_train.txt", sep = "")
train_dt <- data.table(read.table(train_set, stringsAsFactors = F))
train_dt <- subset(train_dt, select = keep_columns)
for (i in 1:length(train_dt)) {
    setnames(train_dt, i, features_dt$name[i])
}
train_dt <- cbind(train_labels_dt, train_subject_dt, train_dt)

# Create data table of test observations, keeping only the previously identified columns
# with mean and standard deviation measurements, using the descriptive feature names,
# and inserting columns for activity and subject_id).
test_set <- paste(unzipped_folder, "/test/X_test.txt", sep = "")
test_dt <- data.table(read.table(test_set, stringsAsFactors = F))
test_dt <- subset(test_dt, select = keep_columns)
for (i in 1:length(test_dt)) {
    setnames(test_dt, i, features_dt$name[i])
}
test_dt <- cbind(test_labels_dt, test_subject_dt, test_dt)

# Combine training and test data tables into new data table, ordered by activity and subject_id.
combined_dt <- rbind(train_dt, test_dt)
setkeyv(combined_dt, c("activity", "subject_id"))

# Create tidy data table from the combined data table,
# calculating the means of each variable by activity and subject_id pair.
tidy_dt <- combined_dt[, lapply(.SD, mean), by = list(activity, subject_id)]

# Create comma-separated flat file of the tidy data table in the current working directory.
tidy_file <- "./Tidy UCI HAR Dataset.txt"
write.table(tidy_dt, file = tidy_file, sep = ",", row.names = F)