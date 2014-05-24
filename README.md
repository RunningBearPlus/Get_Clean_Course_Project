Getting_and_Cleaning_Data_Course_Project
========================================

Getting and Cleaning Data Course Project 

The run_analysis script is based on the following five steps to create 2 tidy datasets
please note, this script will produce 2 tab delimited txt file ( tidy_final.txt and agg_tidy.txt)
You can use read.table("your directory/tidy_final.txt",header = TRUE,sep = "\t") to load the dataset

* 1.Merges the training and the test sets to create one data set.
    
    Merged X_test.txt and X_train.txt together and added header to the merged dataset. The new dataset contains both
    testing and training data from the experiments.

* 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

    Extracted all the columns which contains mean() or std(). After step 2, only 66 variables left.
    
* 3.Uses descriptive activity names to name the activities in the data set

    Loaded activity.txt and activity_labels.txt, and column binding activity.txt to the dataset. 
    Also, assigned descriptive names to replace the number in activity column.
    
* 4.Appropriately labels the data set with descriptive activity names.

    Transformed headers to more english like, and also added subject to the dataset. 
    Output to a tab delimited txt file, named tidy_final.txt

* 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

    Aggregated the dataset by subject and activity, and calculated means on all the other columns.
    Output to a tab delimited txt file, named agg_tidy.txt. 
