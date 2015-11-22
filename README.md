## Getting and Cleaning Data Project

Jonathan Whiters

### Overview
This project serves to demonstrate getting and cleaning test sets to create one data set, then  
converting it to a tidy data set that can be used for subsequent analysis. A full description of the data used can be found at [The UCI Machine Learning Respository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Modification Made to This Script
Once you have downloaded and unzipped the source files, you will need to make one modification to the R file before you can process the data.
On line 25 of run_analysis.r, you wil need to set the path of the working directoy to reflect the location of the source files in your own directory.

### Project Summary
The following is a summary description of the project instructions

You should create one R script called run_analysis.r that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive activity names.
5. Creates a second independent tidy data set with the average of each variable for each activity and each subject.

### Additional Information
You will find additional informatio about the variables, dta, and transformations in the CodeBook.md file.

 
