# This is the code book for the project

# About the source data

The source data are from the Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# About R script
The run_analysis.R script performs the data preparation as instructed in the course project’s definition.

1.Download the dataset and load required libraries

2.Assign each data to variables and Extracts only the measurements on the mean and standard deviation for each measurement
* activityNames <- activity_labels.txt :List of activities performed when the corresponding measurements were taken and its codes (labels)
* features <- features.txt: The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* desiredFeatures <- getting the position of measurements on the mean and standard deviation
* measurements <- filtered features name base on desiredFeatures
* train <- test/X_train.txt :contains recorded features train data
* trainActivities <- test/y_train.txt :contains train data of activities’code labels
* trainSubjects <- test/subject_train.txt : contains train data of 21/30 volunteer subjects being observed
* train <- composite train set created by merging train, trainActivities and trainSubjects using cbind() function
* test <- test/X_test.txt :contains recorded features test data
* testActivities <- test/y_test.txt :contains test data of activities’code labels
* testSubjects <- test/subject_test.txt :contains test data of 9/30 volunteer test subjects being observed
* test <- composite test set created by merging test, testActivities and testSubjects using cbind() function

3.Merges the training and the test sets to create one data set
* combined <- mergeed data is created by merging train and test using rbind() function

4.Uses descriptive activity names to name the activities in the data set
* Entire numbers in Activity column of the merged dataset replaced with corresponding activity name taken from second column of the activities variable

5.Appropriately labels the data set with descriptive variable names:
* All Acc in column’s name replaced by Accelerometer
* All Gyro in column’s name replaced by Gyroscope
* All BodyBody in column’s name replaced by Body
* All Mag in column’s name replaced by Magnitude
* All start with character f in column’s name replaced by Frequency
* All start with character t in column’s name replaced by Time
* All tBody in column’s name replaced by TimeBody

7.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* Average of each variable for each activity and each subject in the merged dataset is created by using dcast function from reshape2 library, after grouped by subject and activity.
* Export the final combined data into tidyData.txt file.
      
        


