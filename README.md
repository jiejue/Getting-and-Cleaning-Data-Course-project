1. Load data into R

> X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
> y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
> subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

> X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
> y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
> subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

2. Merge the training and the test sets for X, y, subject seperately.

X <- rbind(X_train,X_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

3. Take the mean and standard deviation of X for each measurement
mean <- apply(X,1,mean)
std <- apply(X,1,sd)

4. Combine the variables to create a data set
data <- cbind(subject,y, mean, std)

5. Label the data set with descriptive variable names
names(data) <- c("Subject", "Activity", "Mean", "Standard deviation")

6. Use descriptive activity names to name the activities in the data set 
data$Activity[data$Activity == 1] <- "WALKING"
data$Activity[data$Activity == 2] <- "WALKING_UPSTAIRS"
data$Activity[data$Activity == 3] <- "WALKING_DOWNSTAIRS"
data$Activity[data$Activity == 4] <- "SITTING"
data$Activity[data$Activity == 5] <- "STANDING"
data$Activity[data$Activity == 6] <- "LAYING"

7.Create a tidy data set with the average of each variable for each acitvity and each subject
testData <- aggregate(data[,3:4],by=list(Subject <- data$Subject,Activity <- data$Activity),FUN = mean)

8. Label the new data set
names(testData) <- c("Subject","Activity","Mean","Standard Deviation") 

9. Store the tidy data
write.table(testData,"tidyData.txt",rows.name = FALSE)
