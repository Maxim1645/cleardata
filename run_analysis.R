library(dplyr)

x_train <- read.table("train/X_train.txt", colClasses = "numeric")
x_test <- read.table("test/X_test.txt", colClasses = "numeric")

# Add column names
features <- read.table("features.txt", stringsAsFactors=FALSE)
names(x_train) <- features[,2]
names(x_test) <- features[,2]

# Remove unecessary columns
mean_std_indexes <- which(grepl("std|mean", features[,2]))
x_train <- x_train[,mean_std_indexes]
x_test <- x_test[,mean_std_indexes]

# Add subject column to both sets
subject_train <- read.table("train/subject_train.txt", colClasses = "numeric", col.names="subject")
subject_test <- read.table("test/subject_test.txt", colClasses = "numeric", col.names="subject")
x_train <- bind_cols(subject_train, x_train)
x_test <- bind_cols(subject_test, x_test)

# Add activities to both sets
y_train <- read.table("train/y_train.txt", colClasses = "numeric", col.names="activity_index")
y_test <- read.table("test/y_test.txt", colClasses = "numeric", col.names="activity_index")
x_train <- bind_cols(y_train, x_train)
x_test <- bind_cols(y_test, x_test)
# get activity names mapping
activity_labels <- read.table("activity_labels.txt",
                              stringsAsFactors=FALSE,
                              colClasses = c("numeric", "character"),
                              col.names = c("activity_index", "activity"))
# add column with descriptive activity names
x_train <- inner_join(x_train, activity_labels, by="activity_index")
x_test <- inner_join(x_test, activity_labels, by="activity_index")

# Merge the training and the test sets to create one data set
x_data <- bind_rows(x_train, x_test)

# Remove temporary activity_index column
x_data <- select(x_data, -matches("activity_index"))

# Rename columns
names(x_data) <- gsub("-", "_", gsub("[()]", "", names(x_data)))

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
grouped_x <- group_by(x_data, activity, subject)
final_data_set <- summarise_each(grouped_x, funs(mean))

# create file with the resulting data set  
write.table(final_data_set, file="tidy_data_set.txt", row.name=FALSE)
