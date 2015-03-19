## Reorganization of UCI Human Activity Recognition Data based on smartphone acceloremeters

* Data is obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and training and test datasets are combined into one. Then, only mean and standard deviation values are taken for the measurements. Lastly, generating a smaller dataset with only average of each variable for each activiy and each subject. 

* Dataset is downloaded an unzipped manually and then included in the working directory in a folder named as UCIDataset.

* run_analysis.R script which is placed in the same folder with UCIDataset folder gets the various files in UCIDataset folder, reads them, merge and process them so that a tidy dataset is presented which is named as 'UCIHAR_tidy.txt'

* 'subject_test.txt', 'X_test.txt', 'y_test.txt', 'subject_train.txt', 'X_train.txt', 'y_train.txt', 
'feautures.txt', and 'activity_labels.txt' files are imported using read.table with default options

* rbind is used to combine test and train data frames

* As an important step activity labels (which were factors) were converted to characters and used to transform y values

* Features are used to define the names of X coloumns

* grepl function with fixed=TRUE options is used to grep col. names that has 'mean()' or 'std()' eaxctly (excluding cases such as meanFreq() or gravityMean)

* grepped columns are used to generate a narrower data frame (xttms) which as only mean() or std() values

* subject numbers (in stt) and activity names (in ytt) are added to the xttms dat frame with 'subject' and 'label' col. names using cbind function

* melt function of reshape2 library is used to melt down coloumns except subject and label

* dcast function of reshape2 library is used with subject+label~variable formula definition and mean option to get the final ready (tidy) data frame that has average values for measurements (that is mean() or std()) for each subject and each activity (WALKING, etc.)

* write.table function is used with option row.names=FALSE to write the tidy data frame into a txt file
