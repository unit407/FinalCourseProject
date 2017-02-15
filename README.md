# Getting and Cleaning Data - Course Project

This is the final course project for Getting and Cleaning Data.
The R script, `run_analysis.R`, carries out the following actions:

* Load feature and activity info
* Load the columns with a mean or standard deviation from the test and training datasets.
* Loads the subject and activity data for each of these datasets, and merges these
   columns with the datasets.
* Merges both datasets
* Converts the `activity` and `subject` columns of the dataset into factors
* Creates a dataset that contains the mean value of each variable for each subject and activity pair.

The end result is a tidy data table is shown in the file `finalData.txt`.
