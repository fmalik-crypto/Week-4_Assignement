# set the worKing directory where "UCI HAR Dataset" is extracted from downloaded ZIP file "getdata_projectfiles_UCI HAR Dataset.zip"
library(dplyr)

# the following part of script will first extract the test related data from following files: 
testset <- read.table(paste0(getwd(),"./test/X_test.txt"), header = FALSE)
testlables <- read.table(paste0(getwd(),"./test/Y_test.txt"), header = FALSE)
testsubject <- read.table(paste0(getwd(),"./test/subject_test.txt"))

# the following part of script will then extract the train related data from following files:
trainset <- read.table(paste0(getwd(),"./train/X_train.txt"), header = FALSE)
trainlables <- read.table(paste0(getwd(),"./train/Y_train.txt"), header = FALSE)
trainsubject <- read.table(paste0(getwd(),"./train/subject_train.txt"))

# Step No. 1: the following part of script will merge the training and the test sets to create one data set:
dataset <- tbl_df(rbind(testset,trainset))
datalables <- tbl_df(rbind(testlables,trainlables))
datasubject <- tbl_df(rbind(testsubject,trainsubject))
names(datalables) <- "activity"
names(datasubject) <- "subject"
joindf <- tbl_df(cbind(datasubject, datalables, dataset))

# the following part of script will assign variable names to the combined data set extracted from "features.txt":
features <- read.table("features.txt")
names(joindf)[3:length(names(joindf))] <- features$V2

# Step No. 2: the following part of script will extract only the measurements on the mean and standard deviation for each measurement:
tidydataset <- select(joindf, subject, activity, grep("mean[[:punct:]]|std[[:punct:]]", names(joindf), value = TRUE))

# Step No. 3: the following part of script will assign descriptive activity names to name the activities in the data set:
activitylables <- read.table(paste0(getwd(),"./activity_labels.txt"))
tidydataset$activity <- activitylables[tidydataset$activity, 2]
names(tidydataset) <- tolower(gsub("[[:punct:]]", "", names(tidydataset)))

# Step No. 4: the following part of script will appropriately label the the dataset with descriptive variable names and create a new text file with tidy data set named as "tidydataset.txt" in the working directory:
shortnames <- tolower(c("Acc","Gyro","^t","Body","Jerk","Mag","^f","X$","Y$","Z$"))
descriptivename <- tolower(c("Accelerometer","Gyroscope","Time","Body","Jerk","Magnitude","Frequency","X_axis","Y_axis","Z_axis"))
i <- 1
while (i <= length(shortnames)) {
    names(tidydataset)[3:length(names(tidydataset))] <- gsub(shortnames[i], descriptivename[i], names(tidydataset)[3:length(names(tidydataset))])
    i = i + 1
}
write.table("tidydataset.txT=t", row.names = FALSE)

# Step No. 5: the following part of script will create a second independent tidy data set named "secondtidydataset.txt" in the working directory, containing the average of each variable for each activity and each subject:

secondtidydataset <- tidydataset %>% group_by(activity,subject) %>% summarise_all(mean)
write.table("secondtidydataset.txT=t", row.names = FALSE)

# the following part of script will cleanup the memory.
rm(activitylables,datalables,dataset,datasubject,features,joindf,testset,testsubject,testlables,trainlables,trainset,trainsubject, descriptivename,shortnames,i)

