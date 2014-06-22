# CodeBook for Tidy UCI HAR Dataset

## What is it?
This CodeBook describes the data contained in the output of the run_analysis.R script contained in this repository (the Tidy UCI HAR Dataset.txt). The tidy flat file can be read using <b>read.csv</b> to create a data table for further analysis (ex: my_dt <- data.table(read.csv(tidy_file, stringsAsFactors = F))).

The script creates a tidy, condensed version of the University of California Irvine's (UCI's) dataset for Human Activity Recognition (HAR) using smartphones that can be used for further research and analysis. The original UCI HAR Dataset is a public domain dataset built from the recordings of subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensor (see https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf).

As noted in the above referenced document, the original data comes from experiments that were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking_upstairs, walking_downstairs, sitting, standing, and laying) wearing a Samsung Galaxy S II smartphone on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force was assumed to have only low frequency components, so a filter with a 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The script generates a combined subset of the original data by extracting the mean and standard deviation features for each of the 33 processed signals, for a total of 66 features (out of the 561 available features from the original feature vector). This combined subset contains 10299 observations of 68 variables, with activity and subject appended to the 66 features.

The combined subset is further reduced by calculating the mean of the observations by activity and subject pair. The resultant tidy dataset consists of 180 observations (6 activities * 30 subjects) of the same 68 variables and is saved as a comma-separated text file in the current working directory.

## Description of the UCI HAR variables
The Tidy dataset consists of 180 observations summarized by activity (6 categories) and subject (30 volunteers) pairs. For each observation (row) in the Tidy dataset, the following 68 columns are provided:
- The activity name:
    - 'laying',
    - 'sitting', 
    - 'standing',
    - 'walking', 
    - 'walking_downstairs', or
    - 'walking_upstairs'.
- A numeric identifier (1-30) of the subject who carried out the experiment.
- The mean of 66 variables, summarized by activity and subject pair. These variables represent the mean (with names suffixed by _avg) and standard deviation (with names suffixed by _stddev) of the original 33 UCI HAR processed signals described below. Note that these are unitless measures.

The original 33 UCI HAR processed signals fall into two categories:
- 20 time domain signals (with a prefix of 'time_') and
- 13 frequency domain signals (with a prefix of 'freq_').

The time domain signals came from the accelerometer and gyroscope 3-axial raw signals filtered to remove noise. The acceleration signal was separated into body and gravity acceleration signals. The names of these 9 signals are prefixed with:
- 'time_body_accel' by 3-dimensional axis (xaxis, yaxis, and zaxis) (3 variables),
- 'time_gravity_accel' by axis (3 variables), or
- 'time_body_gyro' by axis (3 variables). 

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals. The names of these 6 signals are prefixed with:
- 'time_body_accel_jerk' by axis (3 variables) or
- 'time_body_gyro_jerk' by axis (3 variables).

The magnitude of these three-dimensional signals was also calculated. The names of these 5 signals are prefixed by:
- 'time_body_accel_magn' (1 variable),
- 'time_gravity_accel_magn' (1 variable),
- 'time_body_accel_jerk_mag' (1 variable),
- 'time_body_gyro_magn' (1 variable), or
- 'time_body_gyro_jerk_magn' (1 variable). 

The frequency domain signals were obtained by applying a Fast Fourier Transform (FFT) to some of the signals. The names of these 9 signals are prefixed by:
- 'freq_body_accel' by axis (3 variables),
- 'freq_body_accel_jerk' by axis (3 variables), or 
- 'freq_body_gyro' by axis (3 variables).

The magnitude of these three-dimensional signals was also calculated. The names of these 4 signals are prefixed by:
- 'freq_body_accel_magn' (1 variable),
- 'freq_body_accel_jerk_magn' (1 variable),
- 'freq_body_gyro_magn' (1 variable), or
- 'freq_body_gyro_jerk_magn' (1 variable).

For each of the 33 processed signals above, the mean (with names suffixed by _avg) and standard deviation (with names suffixed by _stddev) were calculated from the samples generated from the fixed-width sliding windows (yielding 66 total measures). Each measure was normalized and bounded within [-1,1], making it a unitless measure.