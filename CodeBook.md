# Introduction
The script `run_analysis.R` cleaned the`Human Acitivity Recognition Using Smartphones` dataset following the requirements of the course

# Data Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Steps taken to clean the data
1. Get the file directories of all the downladed files
2. Read all downloaded files using `read.table`
3. Training and test datasets are merged using`rbind()`. x and y datasets are kept seperate
4. Select only columns with the mean and standard deviation measures from the x dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
5. As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
6. On the whole dataset, those columns with vague column names are corrected.
7. Generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output is generated using `write.table` and is named as `averages_data.txt`

# Variables
* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `all_data` merges `x_data`, `y_data` and `subject_data` in a big dataset.
* `average_data` contains the relevant averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()` and ease the development.