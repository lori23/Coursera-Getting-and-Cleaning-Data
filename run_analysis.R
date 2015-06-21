# Get file directories
getwd()
setwd("/Users/Yui/Documents/UCI HAR Dataset")
dir<-"/Users/Yui/Documents/UCI HAR Dataset"
feature_file<-paste(dir,"/features.txt",sep="")
activity_labels_file<-paste(dir,"/activity_labels.txt",sep="")
x_train_file<-paste(dir, "/train/X_train.txt",sep="")
y_train_file <- paste(dir, "/train/y_train.txt", sep = "")
subject_train_file <- paste(dir, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(dir, "/test/X_test.txt", sep = "")
y_test_file  <- paste(dir, "/test/y_test.txt", sep = "")
subject_test_file <- paste(dir, "/test/subject_test.txt", sep = "")

# Load raw data
features <- read.table(feature_file, colClasses = c("character"))
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

# Merges the training and the test sets to create one data set
x_data<-rbind(x_train, x_test)
y_data<-rbind(y_train, y_test)
subject_data<-rbind(subject_train, subject_test)

# Extract only the measurements on the mean and standard deviation for each measurment
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]

# Use descriptive activity names to name the activities in the data set
y_data[,1]<-activity_labels[y_data[,1],2]
names(y_data)<-"activity"

# Appropriately label the data set with descriptive variable name
names(subject_data)<-"subject"
all_data<-cbind(x_data,y_data,subject_data)

#Create a second, independent tidy data set 
# with the average of each variable for each activity and each subject
library(plyr)
average_data<-ddply(all_data, .(subject, activity),function(x) colMeans(x[,1:66]))
write.table(average_data,"averages_data.txt",row.name=FALSE)
