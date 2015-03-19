# Using UCI HAR dataset and procession it into a tidier format.
# This code works properly when the unzipped Dataset folder is in the same folder with this script.
# The unzipped folder is named as UCIDataset
library(reshape2)

# First, read all the useful files to be merged
stest <- read.table('UCIDataset//test//subject_test.txt')
xtest <- read.table('UCIDataset//test//X_test.txt')
ytest <- read.table('UCIDataset//test//y_test.txt')
strain <- read.table('UCIDataset//train//subject_train.txt')
xtrain <- read.table('UCIDataset//train//X_train.txt')
ytrain <- read.table('UCIDataset//train//y_train.txt')
feature <- read.table('UCIDataset//features.txt')
label <- read.table('UCIDataset//activity_labels.txt')

# Then combine the training and test values of x,y,s datasets
# and change y labels based on label file so that it becomes; 'WALKING', ...
xtt <- rbind(xtrain,xtest)
ytt <- rbind(ytrain,ytest)
stt <- rbind(strain,stest)
for (i in 1:nrow(label)) {
    ytt[ytt==i] <- as.character(label[i,2])}

# Then make the col. names equal to the features for better annotation
colnames(xtt) <- feature[,2]

# Then grep the col. names with mean() or std()
# ! Sticking with values that have both mean() and std(); 
# so ignored cases such as meanFreq(), gravityMean
cx <- colnames(xtt)
xttms <- xtt[,which(grepl('mean()',cx,fixed=TRUE)==TRUE | grepl('std()',cx,fixed=TRUE)==TRUE)]

# Having only mean() and std() col.s now add subject and activity labels
xlab <- cbind(stt,ytt,xttms)
colnames(xlab)[1:2]=c('subject','label')

# Lastly, melt and dcast the dataset so that average value for each subject, activity 
# and variable can be held
cx2 <- colnames(xlab)
xmelt <- melt(xlab,id=c('subject','label'),measure.vars=cx2[3:length(cx2)])
xavg <- dcast(xmelt,subject+label~variable,mean)

# Write the tidy dataset into a txt file
write.table(xavg,file="UCIHAR_tidy.txt",row.names=FALSE)


