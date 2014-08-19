X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

X <- rbind(X_train,X_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

mean <- apply(X,1,mean)
std <- apply(X,1,sd)

data <- cbind(subject,y, mean, std)
names(data) <- c("Subject", "Activity", "Mean", "Standard deviation")

data$Activity[data$Activity == 1] <- "WALKING"
data$Activity[data$Activity == 2] <- "WALKING_UPSTAIRS"
data$Activity[data$Activity == 3] <- "WALKING_DOWNSTAIRS"
data$Activity[data$Activity == 4] <- "SITTING"
data$Activity[data$Activity == 5] <- "STANDING"
data$Activity[data$Activity == 6] <- "LAYING"

testData <- aggregate(data[,3:4],by=list(Subject <- data$Subject,Activity <- data$Activity),FUN = mean)

names(testData) <- c("Subject","Activity","Mean","Standard Deviation") 

write.table(testData,"tidyData.txt",row.name = FALSE)
