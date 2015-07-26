#Author: Darin Asakura
#Class: Getting and Cleaning Data
#Project: Course Project

# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################


# Clean up workspace
        rm(list=ls())

#Load httr package
        library(httr)
        
#Set file perameters for download
        file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        file.name <- "data.zip"
        
# Check to see if the file has already been downloaded        
        if(!file.exists(file.name)){
                print("Download file not found, downloading file...")
                download.file(file.url, file.name, method="curl")
                print("...download complete")
        } else{
                print("File found in working directory")
        }

# Check for data and analysis directory
        data.dir <- "UCI HAR Dataset"
        analysis.dir <- "analysis_folder"
        if(!file.exists(data.dir)){
                print("Data folder not found, unzipping file")
                unzip(file.name, list = FALSE, overwrite = TRUE)
        } else{
                print("Data folder found.")
        }
        
        if(!file.exists(analysis.dir)){
                print("Analysis directory not found, created analysis folder")
                dir.create(analysis.dir)
        } else{
                print("Analysis folder found.")
        }

# TASK 1-Merge the training and the test sets to create one data set.

##Read in data files
        #imports features.txt
        #imports activity_labels.txt
        #imports subject_train.txt
        #imports x_train.txt
        #imports y_train.txt
        #imports subject_test.txt
        #imports x_test.txt
        #imports y_test.txt
        
        print("Loading project data files...")
        # Read in Training Data
        features     <- read.table('./UCI HAR Dataset/features.txt',header=FALSE); 
        activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE); 
        subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE); 
        x_train       <- read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE); 
        y_train       <- read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE); 
        # Read in the test data
        subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE); 
        x_test       <- read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE); 
        y_test       <- read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE); 

        print("...Data files have been loaded")

##Set labels for data columns
        # Assign column names to the training data imported above
        colnames(activity_labels)  <- c('actId','activityType');
        colnames(subject_train)  <- "subjectId";
        colnames(x_train)        <- features[,2]; 
        colnames(y_train)        <- "actId";
        
        # Assign column names to the test data imported above
        colnames(subject_test) <- "subjectId";
        colnames(x_test)       <- features[,2]; 
        colnames(y_test)       <- "actId";
        
        print("Labels added to data tables.")
## Merge tables
        #Training Data merge
        training_data <- cbind(y_train,subject_train,x_train);
        #Test Data merge
        test_data <- cbind(y_test,subject_test,x_test);
        
        print("Training data merged, test data merged.")
# Combine training and test data to create a final data set
        final_data <- rbind(training_data,test_data);
        print("Combined Training and Test Data into final_data.")

# Create a vector with column names from the final_data
        final_data_colNames  <- colnames(final_data);


#################################################################################
# TASK 2 - Extract only the measurements on the mean and standard deviation for each measurement. 
        print("Start Task 2")
# Create a logical_vector: TRUE values for the ID, mean() & stddev() columns; FALSE for others
        logical_vector <- (grepl("act..",final_data_colNames) | grepl("subject..",final_data_colNames) | grepl("-mean..",final_data_colNames) & !grepl("-meanFreq..",final_data_colNames) & !grepl("mean..-",final_data_colNames) | grepl("-std..",final_data_colNames) & !grepl("-std()..-",final_data_colNames));

# Subset finalData table based on the logical_vector to keep only desired columns
        finalData_sub <- final_data[logical_vector==TRUE];
        
        print("Task 2 complete")
#################################################################################
# TASK 3 - Use descriptive activity names to name the activities in the data set
        print("Start Task 3")
# Merge the finaData_sub with the acitivity_labels table to include descriptive activity names
        finalData_merge <- merge(finalData_sub,activity_labels,by='actId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
        final_data_colNames  <- colnames(finalData_merge); 
        
        print("Task 3 complete")
##################################################################################
# 4. Appropriately label the data set with descriptive activity names. 
        print("Start Task 4")
# Cleaning up the variable names
        for (i in 1:length(final_data_colNames)) 
        {
                final_data_colNames[i] <- gsub("\\()","",final_data_colNames[i])
                final_data_colNames[i] <- gsub("-std$","StdDev",final_data_colNames[i])
                final_data_colNames[i] <- gsub("-mean","Mean",final_data_colNames[i])
                final_data_colNames[i] <- gsub("^(t)","time",final_data_colNames[i])
                final_data_colNames[i] <- gsub("^(f)","freq",final_data_colNames[i])
                final_data_colNames[i] <- gsub("([Gg]ravity)","Gravity",final_data_colNames[i])
                final_data_colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",final_data_colNames[i])
                final_data_colNames[i] <- gsub("[Gg]yro","Gyro",final_data_colNames[i])
                final_data_colNames[i] <- gsub("AccMag","AccMagnitude",final_data_colNames[i])
                final_data_colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",final_data_colNames[i])
                final_data_colNames[i] <- gsub("JerkMag","JerkMagnitude",final_data_colNames[i])
                final_data_colNames[i] <- gsub("GyroMag","GyroMagnitude",final_data_colNames[i])
        };

# Reassigning the new descriptive column names to the finalData set
        colnames(finalData_merge) <- final_data_colNames;

# Export the finalData_merge set 
        write.table(finalData_merge, './analysis_folder/finalData.txt',row.names=FALSE);

        print("Task 4 complete")
##################################################################################
# TASK 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
        print("Start Task 5")
# Create a new table, finalData_NoActivityType without the activityType column
        finalData_NoActivityType  <- finalData_merge[,names(finalData_merge) != 'activityType'];

# Summarizing the finalData_NoActivityType table to include just the mean of each variable for each activity and each subject
        tidyData  <- aggregate(finalData_NoActivityType[,names(finalData_NoActivityType) != c('actId','subjectId')],by=list(actId=finalData_NoActivityType$actId,subjectId = finalData_NoActivityType$subjectId),mean);

# Merging the tidyData with activity_labels to include descriptive acitvity names
        tidyData    <- merge(tidyData,activity_labels,by='actId',all.x=TRUE);

# Export the tidyData set 
        write.table(tidyData, './analysis_folder/tidyData.txt',row.names=FALSE);

        print("Task 5 complete")