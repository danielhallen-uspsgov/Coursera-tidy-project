Libraries used
	dplyr
   
Raw Data location
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   
Variables#
	dataFileZip - zip file of dowloaded files
	url - web address of raw data
	
	mainDir - Main directory where files will be stored
	subDir - Sub directory where files will be stored
   
  filename - whole address and file name where raw data is stored on local device
  
  Tables
   activities_labels - raw data activity_labels.txt
   features - raw data features.txt
   subject_test - raw data subject_test.txt
   x_test - raw data X_test.txt
   y_test - raw data y_test.txt
   subject - raw data subject_train.txt
   x_train - raw data X_train.txt
   y_train - raw data y_train.txt
   x_table - binded 'x' files
   y_table - binded 'y' files
   subject_table - binded 'subject' files
   merged_data - Merge all data
   cleaner_data - merged data after removing columns
   tidy_data - final tidy table
   data_Summary - summary of tidy data