# Getting-and-Cleaning-Data-Course-Project
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Héctor Moreno de Mier
==================================================================

The dataset includes the following files:
=========================================

- 'README.md'

- 'CodeBook.md': Shows information about the variables used on the feature vector.

- 'UCI HAR Dataset/train/X_train.txt': Training set.

- 'UCI HAR Dataset/test/X_test.txt': Test set.

- 'UCI HAR Dataset/train/y_train.txt': Training labels.

- 'UCI HAR Dataset/test/y_test.txt': Test labels.

- 'UCI HAR Dataset/train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'UCI HAR Dataset/test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'UCI HAR Dataset/features.txt': List of all features.


- 'run_analysis.R': 	Reads the files with the training test and the test set and creates ona data set.
			It extracts only the measurements on the mean and standard deviation for each measurement. The rest of columns is eliminated.
			It inserts a column with the name of each activity in the data set.
			It inserts a column with the number of each subject in the data set.
			With the dataframe the script creates a new independent tidy data set with the average of each variable for each activity and each subject.
			Finally the script produces a txt file named averages_dataset.txt containing the last data frame.

- 'averages_dataset.txt': tidy data set with the average of each variable for each activity and each subject