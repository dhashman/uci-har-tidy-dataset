# uci-har-tidy-dataset

## What is it?
The University of California Irvine's (UCI's) dataset for Human Activity Recognition (HAR) using smartphones is a public domain dataset built from the recordings of subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensor (see https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf).

As noted in the above referenced document and the associated README.txt in the downloadable zip file, experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWnSTAIRS, SITTING, STANDING, and LAYING) wearing a Samsung Galaxy S II smartphone on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, with 70% of the volunteers selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force was assumed to have only low frequency components, so a filter with a 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each observation, the following data was provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Structure of the UCI HAR Dataset zip file
The zip file is downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for the original source. In the downloaded zip file, a UCI HAR Dataset folder contains the following files/folders:
- README.txt
- features_info.txt: Shows information about the variables used on the feature vector.
- features.txt: List of all features.
- activity_labels.txt: Links the class labels with their activity name.
- test folder with the following files/folders:
    - subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    - X_test.txt: Test set.
    - y_test.txt': Test labels.
    - Inertial Signals folder containing the following files;
        - body_acc_x_test.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
        - body_acc_y_test.txt: Same as above for the y axis.
        - body_acc_z_test.txt: Same as above for the z axis.
        - body_gyro_x_test.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
        - body_gyro_y_test.txt: Same as above for the y axis.
        - body_gyro_z_test.txt: Same as above for the z axis.
        - total_acc_x_test.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector.
        - total_acc_y_test.txt: Same as above for the y axis.
        - total_acc_z_test.txt: Same as above for the z axis.       
- train folder with the same files/folders as the test folder (substituting 'train' for 'test' in the file names).

## Description of UCI HAR Dataset processed signals
In the X_test.txt and X_train.txt datasets, the 33 processed signals fall into two categories:
- 20 time domain signals (with a prefix of 't') and
- 13 frequency domain signals (with a prefix of 'f').

The time domain signals came from the accelerometer and gyroscope 3-axial raw signals filtered to remove noise. The acceleration signal was separated into body and gravity acceleration signals. These signals are prefixed with:
- 'tBodyAcc' by 3-dimensional axis (X, Y, and Z),
- 'tGravityAcc' by axis, or
- 'tBodyGyro' by axis.  

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals. These signals are prefixed with:
- 'tBody_AccJerk' by axis or
- 'tBodyGyroJerk' by axis.

The magnitude of these three-dimensional signals was also calculated. These signals are prefixed by:
- 'tBodyAccMag',
- 'tGravityAccMag',
- 'tBodyAccJerkMag',
- 'tBodyGyroMag', or
- 'tBodyGyroJerkMag'. 

The frequency domain signals were obtained by applying a Fast Fourier Transform (FFT) to some of the signals. These signals are prefixed by:
- 'fBodyAcc' by axis,
- 'fBodyAccJerk'by axis, or 
- 'fBodyGyro' by axis.

The magnitude of these three-dimensional signals was also calculated. These signals are prefixed by:
- 'fBodyAccMag',
- 'fBodyAccJerkMag',
- 'fBodyGyroMag', or
- 'fBodyGyroJerkMag'.

## Description of UCI HAR Dataset feature vector
From each sampled observation of the 33 processed signals, a feature vector consisting of 561 measures was derived. The measures were defined as follows:

- For each of the 33 processed signals, the following 8 measures were derived (264 total features):
    - mean(): Mean value
    - std(): Standard deviation
    - mad(): Median absolute deviation 
    - max(): Largest value in array
    - min(): Smallest value in array
    - energy(): Energy measure. Sum of the squares divided by the number of values. 
    - iqr(): Interquartile range 
    - entropy(): Signal entropy

- For each of the 17 overall signal categories (not broken down by axis), the following measure was derived (17 total features):
    - sma(): Signal magnitude area

- For the 20 time domain signals, the following 4 measures were derived (80 total features):
    - arCoeff(): Autorregresion coefficients with Burg order equal to 4 (4 measurements)

- For the 5 basic non-magnitude time domain signal categories (not broken down by axis), the following 3 measures were derived (15 total features):
    - correlation(): correlation coefficient between two signal axes (3 measurements)

- For the 13 frequency domain signals, the following 4 measures were derived (52 total features):
    - maxInds(): index of the frequency component with largest magnitude
    - meanFreq(): Weighted average of the frequency components to obtain a mean frequency
    - skewness(): skewness of the frequency domain signal 
    - kurtosis(): kurtosis of the frequency domain signal

- For the 3 basic non-magnitude frequency domain signal categories (not broken down by axis), the following 42 band measures were derived (126 total features):
    - bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window (42 measurements)

- Additional vectors were obtained by averaging the signals in a signal window sample in order to compute the following 7 angle measures (7 total features): 
    - angle(): Angle between two vectors.
        - angle(tBodyAccMean,gravity)
        - angle(tBodyAccJerkMean),gravityMean)
        - angle(tBodyGyroMean,gravityMean)
        - angle(tBodyGyroJerkMean,gravityMean)
        - angle(X,gravityMean)
        - angle(Y,gravityMean)
        - angle(Z,gravityMean)
        
Each feature was normalized and bounded within [-1,1], making it a unitless measure. The feature vector for each observation was represented by a row in the randomly partitioned X_test.txt and X_train.txt files.

## Purpose and description of the 'run_analysis.R' script
The purpose of the 'run_analysis.R' script is to create a tidy dataset consisting of a subset of the UCI HAR Dataset, The tidy dataset is written out as a comma-separated text file that can be subsequently read back in using read.csv to re-create the data table for further analysis.

The script first generates a combined subset of the data by extracting the mean and standard deviation features for each of the 33 processed signals in the X_test.txt and X_train.txt files, for a total of 66 features out of the 561 available features in the feature vector. Other features with 'mean' in their names, such as meanFreq(), were intentionally excluded because they only pertained to a subset of the processed signals.

This combined subset contains 10299 observations of 68 variables (with activity and subject appended to the 66 features). The combined subset is then further reduced by calculating the mean of the observations by activity and subject pair. The resultant tidy dataset consists of 180 observations (6 activities * 30 subjects) of the same 68 variables and is saved as a comma-separated text file in the current working directory.

Specifically, the script accomplishes the following:
- Downloads a cloud-based zipped copy of the UCI HAR dataset ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") if it does not already exist in the current working directory.
- Unzips the "UCI HAR Dataset" folder if it does not already exist in the current working directory.
- Creates a data table of activity names (from the "/activity_labels.txt" file in the unzipped folder) in lower case with a descriptive column name. <b>(NOTE: This relates to Requirement 3 of the Course Project: Uses descriptive activity names to name the activities in the data set.)</b>
- Creates a data table of feature names (from the "/features.txt" file in the unzipped folder), eliminating the first column, and adding a descriptive column name. <b>(NOTE: This relates to Requirement 2 of the Course Project: Extracts only the measurements on the mean and standard deviation for each measurement.)</b>
- Determines which feature names identify mean and standard deviation measurements. <b>(NOTE: This relates to Requirement 2 of the Course Project: Extracts only the measurements on the mean and standard deviation for each measurement.)</b>
- Translates the row numbers of the selected feature names into column numbers. <b>(NOTE: This relates to Requirement 2 of the Course Project: Extracts only the measurements on the mean and standard deviation for each measurement.)</b>
- Keeps only the mean and standard deviation feature names. <b>(NOTE: This relates to Requirement 2 of the Course Project: Extracts only the measurements on the mean and standard deviation for each measurement.)</b>
- Makes feature names more descriptive by following Hadley wickham's style guide (http://adv-r.had.co.nz/Style.html) by changing <b>(NOTE: This relates to Requirement 4 of the Course Project: Appropriately labels the data set with descriptive variable names.)</b>:
    - 'BodyBody' to 'body_'
    - 'Body' to 'body_'
    - The leading 'f' to 'freq_'
    - 'Acc' to 'accel_'
    - 'Gravity' to 'gravity_'
    - 'Jerk' to 'jerk_'
    - 'Gyro' to'gyro_'
    - '-mean()-X' to 'xaxis_avg'
    - '-mean()-Y' to 'yaxis_avg'
    - '-mean()-Z' to 'zaxis_avg'
    - '-std()-X' to 'xaxis_stddev'
    - '-std()-Y' to 'yaxis_stddev'
    - '-std()-Z' to 'zaxis_stddev'
    - 'Mag-mean() to 'magn_avg'
    - 'Mag-std()' to 'magn_stddev'
- Creates a data table of subject IDs from the training dataset ("/train/subject_train.txt" in the unzipped folder"), adding a descriptive column name. <b>(NOTE: This relates to Requirement 4 of the Course Project: Appropriately labels the data set with descriptive variable names.)</b>
- Creates a data table of subject IDs from the test dataset ("/test/subject_test.txt" in the unzipped folder), adding a descriptive column name. <b>(NOTE: This relates to Requirement 4 of the Course Project: Appropriately labels the data set with descriptive variable names.)</b>
- Creates a data table of activity IDs from the training dataset ("/train/y_train.txt" in the unzipped folder), adding a descriptive column name, and replacing the activity IDs with their associated activity names. <b>(NOTE: This relates to Requirement 4 of the Course Project: Appropriately labels the data set with descriptive variable names.)</b>
- Creates a data table of activity IDs from the test dataset ("/test/y_test.txt" in the unzipped folder), adding a descriptive column name, and replacing the activity IDs with their associated activity names. <b>(NOTE: This relates to Requirement 4 of the Course Project: Appropriately labels the data set with descriptive variable names.)</b>
- Creates a data table of the training observations ("/train/X_train.txt" in the unzipped folder), keeping only the previously identified columns with mean and standard deviation measurements, using the descriptive feature names, and inserting columns for activity and subject_id). <b>(NOTE: This relates to Requirement 2 of the Course Project: Extracts only the measurements on the mean and standard deviation for each measurement.)</b>
- Creates a data table of test observations ("/test/X_test.txt" in the unzipped folder), keeping only the previously identified columns with mean and standard deviation measurements, using the descriptive feature names, and inserting columns for activity and subject_id). <b>(NOTE: This relates to Requirement 2 of the Course Project: Extracts only the measurements on the mean and standard deviation for each measurement.)</b>
- Combines the training and test data tables into a new data table, ordered by activity and subject_id. <b>(NOTE: This relates to Requirement 1 of the Course Project: Merges the training and the test sets to create one data set.)</b>
- Creates a tidy data table from the combined data table, calculating the means of each variable in the combined data table by activity and subject_id pair. <b>(NOTE: This relates to Requirement 5 of the Course Project: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.)</b>
- Creates a comma-separated flat file of the tidy data table ("./Tidy UCI HAR Dataset.txt") in the current working directory. <b>(NOTE: This relates to Requirement 5 of the Course Project: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.)</b>

The tidy flat file can be subsequently read back in using <b>read.csv</b> to re-create the data table for further analysis (ex: my_dt <- data.table(read.csv(tidy_file, stringsAsFactors = F))). To prove that the re-created data table is identical, use the compare package as illustrated below:

> library(compare)

> new_tidy_dt <- data.table(read.csv(tidy_file, stringsAsFactors = F))

> print(compare(data.frame(new_tidy_dt),data.frame(tidy_dt)))

For detailed information on the flat file output of this script, please consult the associated CodeBook.md in this repository.