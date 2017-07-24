# Getting and Cleaning Data Course Project

This script summarizes the UCI HAR data by combining the training and test data sets and calculating an average value of the aggregations of the mean and std dev for each of the features in the main data sets.

The result is an output table containing aggregates of aggregates.

## Data Sources

Data used by this project can be obtained from the researcher's host:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Column Names
subject -- a unique integer identifying each data contributor<br>
activity -- one of six possible activites a contributor can perform.<br>
The unique values are: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"<br><br>
### Aggregated features
This data set contains a column for each average value.
tBodyAccMag-mean()<br>
tBodyAccMag-std()<br>
tGravityAccMag-mean()<br>
tGravityAccMag-std()<br>
tBodyAccJerkMag-mean()<br>
tBodyAccJerkMag-std()<br>
tBodyGyroMag-mean()<br>
tBodyGyroMag-std()<br>
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()<br>
fBodyAccMag-mean()<br>
fBodyAccMag-std()<br>
fBodyBodyAccJerkMag-mean()<br>
fBodyBodyAccJerkMag-std()<br>
fBodyBodyGyroMag-mean()<br>
fBodyBodyGyroMag-std()<br>
fBodyBodyGyroJerkMag-mean()<br>
fBodyBodyGyroJerkMag-std()<br>
