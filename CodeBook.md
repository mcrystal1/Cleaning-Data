The following modification on the data were carried out:
1. Merging the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement. 
3. Using descriptive activity names to name the activities in the data set
4. Appropriately labeling the data set with descriptive variable names. 
5. Creating a second independent tidy data set with the average of each variable for each activity and each subject.

Variabels in the code:
1. train_x, test_x, train_y, text_y, train_subject, test_subject - dataframes from original text data sets in the unzipped files.
2. main_x, main_y, main_subject - merged dataframes 
3. main_data - a dataframe containing all the merged data
4. names - the names of the features 
5. extracted_data - a subset of main_data containing only the measurements on the mean and standard deviation for each measurement.
6. additional - the second independent tidy data frame the average of each variable for each activity and each subject.
7. tidy_set.txt - the text file of the second tidy data frame (additional)
