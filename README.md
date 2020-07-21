This Readme.md file contains important information related to run_analysis.R script and its exection.
**********************************************************
Important Instrutions: Set the worKing directory where "UCI HAR Dataset" is extracted from downloaded ZIP file "getdata_projectfiles_UCI HAR Dataset.zip". Once the working directory is set as prescribed, please run the the "run_analysis.R" script.
**********************************************************

he script will perform following steps:

(1) the script will first extract the test related data from following files:

- UCI HAR Dataset/test/X_test.txt
- UCI HAR Dataset/test/Y_test.txt
- UCI HAR Dataset/test/subject_test.txt

(2) the script will then extract the train related data from following files:

- UCI HAR Dataset/train/X_train.txt
- UCI HAR Dataset/train/Y_train.txt
- UCI HAR Dataset/train/subject_train.txt

Step No. 1: the script will merge the training and the test sets to create one data set. The script will then assign variable names to the combined data set extracted from "features.txt":

Step No. 2: the script will extract only the measurements on the mean and standard deviation for each measurement.

Step No. 3: the script will assign descriptive activity names to name the activities in the data set.

# Step No. 4: the script will appropriately label the the dataset with descriptive variable names and create a new text file with tidy data set named as "tidydataset.txt" in the working directory.

# Step No. 5: the script will create a second independent tidy data set named "secondtidydataset.txt" in the working directory, containing the average of each variable for each activity and each subject. The following part of script will cleanup the memory.

Thankyou for using run_analysis.R :)
