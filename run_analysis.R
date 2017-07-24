# This script summarizes the UCI HAR data by combining the
# training and test data sets and calculating an average
# value of the aggregations of the mean and std dev for 
# each of the features in the main data sets.
#
# The result is an output table containing aggregates of
# aggregates.


# Read a table describing the column names of the X table
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ", col.names = c("num", "feature"), colClasses = c("integer", "character"))

# Read a table describing the activity factors
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ", col.names = c("num", "activity"), colClasses = c("integer", "character"))


# Load tabular data from two Train and two Test data sets into variables
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = c("subject"), colClasses = c("factor"))
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = c("activity"), colClasses = c("factor"))
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = c("subject"), colClasses = c("factor"))
testy <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = c("activity"), colClasses = c("factor"))


# The X data sets are fixed-width with 561 columns; each column is 16 chars wide. Columns names are provided by features.txt
trainx <- read.fwf("./UCI HAR Dataset/train/X_train.txt", widths = rep(16, each=561), header = FALSE, col.names = features[,2])
testx <- read.fwf("./UCI HAR Dataset/test/X_test.txt", widths = rep(16, each=561), header = FALSE, col.names = features[,2] )


# Combine the Training and Test sets into a single data frame for each
trainset <- cbind(trainsubject,trainy,trainx)
testset <- cbind(testsubject,testy,testx)


# [INSTRUCTION 1.] Merge the training and the test sets to create one data set.
# This also restores the original feature names to the combined set.
combinedset <- rbind(trainset, testset)


# [INSTRUCTION 4.] Appropriately label the data set with descriptive variable names.
fixnames <- c("subject","activity",features$feature)
colnames(combinedset) <- fixnames


# [INSTRUCTION 3.] Update activity factors based on activity_labels.txt
# Iterates over each row in activities
for (i in 1:nrow(activities)) {
  levels(combinedset$activity)[levels(combinedset$activity)==activities[i,]$num] <- activities[i,]$activity
}


# [INSTRUCTION 2.] Extract only the measurements on the mean and standard deviation for each measurement.
# A unified regex is uses to select columns from the combined set to build the reduced set
reducedcombinedset <- combinedset[,which(grepl("^(subject|activity)|\\-(mean|std)\\(\\)$",colnames(combinedset)))]

# [INSTRUCTION 5.] From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
avgreducedcombinedset <- aggregate.data.frame(reducedcombinedset[,3:ncol(reducedcombinedset)], by = list(reducedcombinedset$subject, reducedcombinedset$activity), "mean")

# Restore subject and activity column names
colnames(avgreducedcombinedset) <- c("subject","activity",colnames(avgreducedcombinedset[,3:ncol(avgreducedcombinedset)]))

# Sort the dataframe by subject numerically, then activity alphabetically
avgreducedcombinedset <- avgreducedcombinedset[order(as.integer(as.character(avgreducedcombinedset$subject)), as.character(avgreducedcombinedset$activity)),]

# Export the aggregated data set to a comma-delimited file
write.table(avgreducedcombinedset , "HAR_means_by_subject-activity.txt", row.names = FALSE)
