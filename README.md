The script will create a directory C:\coursera\GetAndCleanData\final if one does not exist. 
It will then download the  file “https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" into a the above directory with the name "Getting_and_Cleaning_Data.zip"
The file will be unzipped then read into R as tables. 
Throughout the script tables and variables will be removed when no longer needed.  
The tables will be combined into one table.  First by binding like tables.  Then merging them into one table.  Unnecessary columns will be removed.  
Column headers are changed to a more readable format.  The data is moved to a table named “tidy_data”.  Finally, another table named “data_Summary” which contains the summarized data.
