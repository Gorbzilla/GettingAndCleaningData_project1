# GettingAndCleaningData_project1
This repository contains the project from the Getting and Cleaning Data course.
Raw data was downloaded as part of this project, and extracted to the working folder

The following files are contained within this repository:

- README.md - This readme file
- codebook.md - a codebook describing the tidydata.txt file in the repository
- tidydata.txt - a tidy dataset summarising various mean and std variables by subject and activity
- run_analysis.R - R code to read in the raw data, clean it, and create two tidy datasets

### run_analysis.R

The code does the following

1. Setup
  * imports packages
  * defines character strings with paths to raw files
  * read in each file to a series of data frames
  * attaches column names to the train and test raw files
  
2. Combines the test and train data

3. Keeps only the ID variables, and those containing mean() or std()

4. Renames the variables to be more descriptive

5. Transform the actvNum numeric value to a character description (held in the variable Activity)
  * this step creates a data frame called 'tidyData'

6. Creates a summary data frame, containing the mean of each variable, for each combination of Subject and Activity
  * this step creates a data frame called 'summaryData'
  * also outputs the summaryData data frame to a text file, 'tidydata.txt'
  
  



