# set the worKing directory where "UCI HAR Dataset" is extracted from downloaded ZIP file "getdata_projectfiles_UCI HAR Dataset.zip"
library(dplyr)

# read test dataset 
testset <- read.table(paste0(getwd(),"./test/X_test.txt"), header = FALSE)
# read test lables 
testlables <- read.table(paste0(getwd(),"./test/Y_test.txt"), header = FALSE)


# read train dataset 
trainset <- read.table(paste0(getwd(),"./train/X_train.txt"), header = FALSE)
# read test lables 
trainlables <- read.table(paste0(getwd(),"./train/Y_train.txt"), header = FALSE)


testsubject <- read.table(paste0(getwd(),"./test/subject_test.txt"))

trainsubject <- read.table(paste0(getwd(),"./train/subject_train.txt"))


dataset <- tbl_df(rbind(testset,trainset))

datalables <- tbl_df(rbind(testlables,trainlables))

names(datalables) <- "activity"

datasubject <- tbl_df(rbind(testsubject,trainsubject))

names(datasubject) <- "subject"

joindf <- tbl_df(cbind(datasubject, datalables, dataset))

features <- read.table("features.txt")

names(joindf)[3:length(names(joindf))] <- features$V2

tidydataset <- select(joindf, subject, activity, grep("mean[[:punct:]]|std[[:punct:]]", names(joindf), value = TRUE))

activitylables <- read.table(paste0(getwd(),"./activity_labels.txt"))

tidydataset$activity <- activitylables[tidydataset$activity, 2]

names(tidydataset) <- tolower(gsub("[[:punct:]]", "", names(tidydataset)))

#use descriptive names

shortnames <- tolower(c("Acc","Gyro","^t","Body","Jerk","Mag","^f","X$","Y$","Z$"))
descriptivename <- tolower(c("Accelerometer","Gyroscope","Time","Body","Jerk","Magnitude","Frequency","X_axis","Y_axis","Z_axis"))
i <- 1

while (i <= length(shortnames)) {
    names(tidydataset)[3:length(names(tidydataset))] <- gsub(shortnames[i], descriptivename[i], names(tidydataset)[3:length(names(tidydataset))])
    i = i + 1
}

rm(activitylables,datalables,dataset,datasubject,features,joindf,testset,testsubject,testlables,trainlables,trainset,trainsubject, descriptivename,shortnames,i)


secondtidydataset <- tidydataset %>% group_by(activity,subject) %>% summarise_all(mean)

write.table("tidydataset.txT=t", row.names = FALSE)

write.table("secondtidydataset.txT=t", row.names = FALSE)
