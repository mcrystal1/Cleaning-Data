library(dplyr)
library(tidyr)

# dowloand the data
directory <- "./data"
file_name <- "wearable.zip"
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- paste(directory,"/",file_name,sep = '')


if(!file.exists(directory)){
        dir.create(directory)
        download.file(url, destfile = dir)
}

# unzip files
unzip(zipfile = dir)

## 1. get training and testing data and merging

# training 
train_x<-read.table("./UCI HAR Dataset/train/X_train.txt")
train_x <- as.tbl(train_x)
train_y<-read.table("./UCI HAR Dataset/train/y_train.txt")
train_y <- as.tbl(train_y)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_subject<-as.tbl(train_subject)

# testing
test_x<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_x <- as.tbl(test_x)
test_y<-read.table("./UCI HAR Dataset/test/y_test.txt")
test_y <- as.tbl(test_y)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_subject<-as.tbl(test_subject)

## merge data sets 
main_x<-rbind(train_x,test_x)
main_y<-rbind(train_y,test_y)
main_subject<-rbind(train_subject,test_subject)

## column names - step 4

feat <- read.table("./UCI HAR Dataset/features.txt")
names <- feat[,2]
colnames(main_x)<-names

colnames(main_y)<-"activity_num"
colnames(main_subject)<-"subject_num"

# merge all data
main_data <- cbind(main_x,main_y,main_subject)

### 2. Extracting only mean and stdev for each measurement 

names<-colnames(main_data)
extract<- (grepl("mean",names) | grepl("std",names) | grepl("activity_num",names) | grepl("subject_num",names))

extracted_data <- main_data[,extract]

### 3. name activities in the data set

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_label <- as.character(activity[,2])
extracted_data$activity_num<-factor(extracted_data$activity_num,levels = activity[,1],labels = activity_label)

### step 4 completed before - see above 

### 5. creating a second independent tidy set

additional <- aggregate(.~activity_num + subject_num,extracted_data,mean)
additional <- additional[order(additional$activity_num,additional$subject_num),]

write.table(additional,"tidy_set.txt",row.names = FALSE)
