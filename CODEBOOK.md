---
title: "CodeBook.md"
author: "Darin Asakura"
---



##Study design

The data was taken from a study conducted by Jorge L. et al. called "Human Activity Recognition Using Smartphones Dataset". There is a paper description at 
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 
and all the data is in a zip file at 
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

##Raw data

Their data was obtained from carrying out experiments with 30 participants performing six different activities while wearing a smartphone. The data was randomly split into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. Using the phone's embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

---
|File Name|Description|
|:---:|:---:|
|subject_test.txt | Contains the participant number (1-30) for the test data|
|y_test.txt | contains the activity number (1-6) for the test data|
|x_test.txt | contains the vector information (1-531) for the test data|
|subject_training.txt | contains the participant number (1-30) for the training data|
|y_training.txt | contains the activity number (1-6) for the training data|
|x_trainingt.txt | contains the vector information (1-531) for the training data|
|features.txt | contains the descriptive names of activities|
---

For more detailed information on the original data set consult the README.txt file included in the original project.

##Transformations

The data and labels were loaded into R. The identifier column names were given more appropriate labels such as "actId" and "subjectId". The vector measurement column names were renamed according to the features.txt file. The resultant names descriptive yet readable and succint due to the dashes and camel case. Some examples include:

tBodyGyroJerkMag-mad()              
tBodyGyroJerkMag-max() 

The next step was to merge the test and training data sets into a single data frame. Then the combined data frame was used to create a data frame that displayed only mean and standard deviation data.  This was done by by searching and filtering the column names for "std" and "mean". These filtered columns were combined with the identifier columns to create a new data frame.

The numeric labels for activities was used to convert to descriptive ones using the map values function and activity_labels text file. They produced the following labels.

WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING

Then an independent tidy data frame was created using the aggretate function with the average of each variable for each activity and each subject. As a result of aggregating, new columns were made making some of the old ones unneccessary. The old ones were deleted and the new ones were renamed.

The tidy data frame was written to a file called "tinyData.csv" in the working directory.

##Data Dictionary

The identifiers are as follows:

subjectId - the participant number (1-30)
actId - the activity number (1-6)

The vector information contains 81 rows that are compromised of many elements for each measurement. For example "tBodyAcc-mean-X" denotes a measurement of the mean of a person's acceleration along the x axis as calculated using time. Below are the list of parameters that appear in the tidy data set:

|Perameter|Description|
|:---:|:---:|
|time prefix | measurement was calculated using the time domain|
|freq prefix | measurement was calculated using the frequency domain|
|Body | the person's own movement|
|Gravity | movement due to gravity|
|Acc | acceleration - m/s^2|
|Jerk | jerk - m/s^3|
|Gyro | angular velocity - radians/s|
|Magnitude | magnitude using the Euclidean norm|
|stdDev | standard deviation|
|mean | average|
|x, y, z | which axis the measurement corresponds to|