library(plyr)

## Merge the training and test sets to create one data set

##############################################################
xtrain <-  read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
subjecttrain <- read.table("train/subject_train.txt")

xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
subjecttest <- read.table("test/subject_test.txt")

### creating 'x' data set

xdata <- rbind(xtrain, xtest)

### creating 'y' data set

ydata <- rbind(ytrain, ytest)

### creating 'subject' data set

subjectdata <- rbind(subjecttrain, subjecttest)

### Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt")

### get only columns with mean() and std()

mean_and_std <- grep("-(mean|std)\\(\\)", features[,2])

###subsetting desired columns

xdata <- xdata[, mean_and_std]

### correcting column names

names(xdata) <- features[mean_and_std,2]

### using descriptive activity names

activities <- read.table("activity_labels.txt")

### updating correct activity names

ydata[,1] <- activities[ydata[,1],2]

### correct column name

names(ydata) <- "activity"

### Appropriate labels 

names(subjectdata) <- "subject"

### binding all the data in single data set

data <- cbind(xdata,ydata,subjectdata)

### creating tidy data set

averages_data <- ddply(data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)