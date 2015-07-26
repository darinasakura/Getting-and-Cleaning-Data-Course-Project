# Getting-and-Cleaning-Data-Course-Project

For the submission of the course project for the Coursera - Johns Hopkins - Getting and Cleaning Data course.

##Overview

This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent analysis. A full description of the data used in this project can be found at The UCI Machine Learning Repository:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

The source data for this project can be found here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

##Making Modifications to This Script

Download and unzip the source files, you will need to make one modification/verification to the R file before you can process the data. You will need to verify that file paths to data txt files are valid.

##Project Summary

The following is a summary description of the project instructions

You should create one R script called run_analysis.R that does the following. 1. Merges the training and the test sets to create one data set. 2. Extracts only the measurements on the mean and standard deviation for each measurement. 3. Uses descriptive activity names to name the activities in the data set 4. Appropriately labels the data set with descriptive activity names. 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Explanation of Contents
|File|Description|
|---|---|
|run_analysis.R| Downloads all the required files to complete this assignment and creates a big file finalData.csv and a small file tidydata.csv (both are stored in /analysis_folder)|
|CODEBOOK.md|A brief explanation of what run_analysis.R does|

##Additional Information

You can find additional information about the variables, data and transformations in the CODEBOOK.MD file.
