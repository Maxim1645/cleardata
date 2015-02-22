---
title: "README.md"
output: html_document
---

### Cleaning Human Activity Recognition Using Smatrfones Dataset

Location of initial data for the analysis: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.   

Script "run_analysis.R" prepares tidy data from the initial data files.
Note that library "dplyr" should be installed before running script "run_analysis.R".
Working directory should be set to unzipped folder "UCI HAR Dataset" when running the script.

The steps done during analysis:

1. Reading data from x_train and x_test datasets (files: "train/X_train.txt" and "test/X_test.txt")
2. Getting column names from file "features.txt". Setting them to x_train and x_test datasets gotten in step 1.
3. Removing columns where column names does not contain "mean" or "std" from both x_train and x_test because we are interested only in the mean and standard deviation for each measurement.
4. Reading subject data from files "train/subject_train.txt" and "test/subject_test.txt". Creating new columns "subject" in both datasets with subject data.
5. Getting activities from "train/y_train.txt" and "test/y_test.txt". Adding a temporary column "activity_index" to x_train and x_test with numeric activity IDs. Reading a mapping from activity IDs to descriptive labels from file "activity_labels.txt". Joining the mapping table with x_train and x_test datasets, so that an additional column appears with descriptive activity names.
6. Merging the training and the test sets (x_train and x_test) to create one data set
7. Removing temporary activity_index column
8. Changing column names in the resulting dataset (Replaced "-" with "_", and removed "(", ")" signs).
9. Grouping the dataset by activity and subject. Applying function "mean"" to each measurement grouped using function summarise_each(). Achieving by that an independent tidy data set with the average of each variable for each activity and each subject. 



