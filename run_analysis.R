##Step NO.1
##Merges the training and the test sets to create one data set.

##load feature.txt from working directory
feature<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = F)
##load X_test.txt from working directory
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt",colClasses = "numeric")
##assign feature varibles to X_test as the header
names(X_test)<-feature[,2]
##load X_train.txt from working directory
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt",colClasses = "numeric")
##assign feature varibles to X_train as the header
names(X_train)<-feature[,2]
##combine X_test and X_train into one dataset, named full_dataset.
full_dataset<-rbind(X_train,X_test)

##Step No.2
##Extracts only the measurements on the mean and standard deviation for each measurement.

##extract all the meansurements on the mean
extract_mean<-full_dataset[,grep("mean()",fixed = TRUE,names(full_dataset))]
##extract all the meansurements on the std
extract_std<-full_dataset[,grep("std()",fixed = TRUE,names(full_dataset))]
##combine extract_mean and extract_std to one dataset, including both mean and std related columns
cmeasure<-cbind(extract_mean,extract_std)

##Step No.3
##Uses descriptive activity names to name the activities in the data set

##load y_test.txt from working directory
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",stringsAsFactors = F)
##load y_train.txt from working directory
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",stringsAsFactors = F)
##load activity_labels.txt from working directory
activity_label<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = F)
##row binding for activity
activity<-rbind(y_train,y_test)
##assgin a name to the new variable.
names(activity)<-"activity"
##adding activity clomun to the cmeasure dataset
measure_activity <-cbind(activity,cmeasure)
## replace the number with descriptive activity names for activity column
## by referencing the activity names in activity_label dataset.
for (i in 1:nrow(measure_activity)){
        if (measure_activity$activity[i] == 1){
               measure_activity$activity[i] <- "WALKING"                
        }else
        if (measure_activity$activity[i] == 2){
                measure_activity$activity[i] <- "WALKING_UPSTAIRS"  
        }else
        if (measure_activity$activity[i] == 3){
                measure_activity$activity[i] <- "WALKING_DOWNSTAIRS"  
        }else
        if (measure_activity$activity[i] == 4){
                measure_activity$activity[i] <- "SITTING"  
        }else
        if (measure_activity$activity[i] == 5){
                measure_activity$activity[i] <- "STANDING"  
        }else
        if (measure_activity$activity[i] == 6){
                measure_activity$activity[i] <- "LAYING"  
        }        
}

##Step No.4
##Appropriately labels the data set with descriptive activity names. 

## Transfrom headers to more english like names
clearnames<-gsub("()","",fixed = TRUE,names(measure_activity))
clearnames<-gsub("-",".",fixed = TRUE,clearnames)
names(measure_activity)<-clearnames
##load subject_test.txt from working directory
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",stringsAsFactors = F)
##load subject_train.txt from working directory
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",stringsAsFactors = F)
##combine subject_test and subject_train
subject<-rbind(subject_train,subject_test)
names(subject)<-"subject"
##adding new variable subject to measuer_activity dataset.
tidy_final<-cbind(subject,measure_activity)
##output to tab delimited txt file
write.table(tidy_final,"tidy_final.txt",sep="\t")

##Step No.5
##Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##group the dataset by subject and activity, apply the mean on all other columns.
agg_tidy<-aggregate.data.frame(tidy_final[-c(1,2)],list(tidy_final$subject,tidy_final$activity),mean)
names(agg_tidy)[1:2]<-c("subject","activity")

##output to tab delimited txt file
write.table(agg_tidy,"agg_tidy.txt",sep="\t")















