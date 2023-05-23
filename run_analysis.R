# Load Packages and get the Data
# Package names
packages <- c("data.table", "reshape2")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
sapply(packages, require, character.only=TRUE, quietly=TRUE)
path <- "C:/Users/bidhan.chakraborty/Downloads/R/UCI_HAR_Dataset"

# Load activity labels + features
activityNames <- fread(file.path(path, "/activity_labels.txt")
                       , col.names = c("S.No", "activityName"))
features <- fread(file.path(path, "/features.txt")
                  , col.names = c("S.No", "featureNames"))
desiredFeatures <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[desiredFeatures, featureNames]
measurements <- gsub('[()]', '', measurements)

# Load train datasets
train <- fread(file.path(path, "/train/X_train.txt"))[, desiredFeatures, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "/train/Y_train.txt")
                         , col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "/train/subject_train.txt")
                       , col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)

# Load test datasets
test <- fread(file.path(path, "/test/X_test.txt"))[, desiredFeatures, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "/test/Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(path, "/test/subject_test.txt")
                      , col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# merge datasets
combined <- rbind(train, test)

# Convert classLabels to activityName basically. More explicit. 
combined[["Activity"]] <- factor(combined[, Activity]
                                 , levels = activityNames[["S.No"]]
                                 , labels = activityNames[["activityName"]])

combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)

names(combined)<-gsub("Acc", "Accelerometer", names(combined))
names(combined)<-gsub("Gyro", "Gyroscope", names(combined))
names(combined)<-gsub("BodyBody", "Body", names(combined))
names(combined)<-gsub("Mag", "Magnitude", names(combined))
names(combined)<-gsub("^t", "Time", names(combined))
names(combined)<-gsub("^f", "Frequency", names(combined))
names(combined)<-gsub("tBody", "TimeBody", names(combined))

data.table::fwrite(x = combined, file = "tidyData.txt", quote = FALSE)
