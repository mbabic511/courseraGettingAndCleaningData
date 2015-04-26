# Coursera Getting And Cleaning Data Course Project

The solution of a project is in a `run_analysis.R` file. The file contains a `run_analysis` function.
This function does following operations:

  - loading needed libraries
  - loading raw data for test and train sets
  - loading column names
  - generating easily-readable names
  - asigning names to raw-data columns
  - filtering out only columns with 'mean' and 'std' substrings
  - loading test and train activities information
  - loading test and train subjects information
  - combining those columns with raw data for test and train sets; renaming new columns
  - merging test and train sets
  - loading factor labels for activities; factorising 'Activity' column 
  - generating narrow output: melting, grouping and summarising data
  - writing output in working directory to a file `summary.txt`

Note: function assumes that you have folder in your working directory called `UCI HAR Dataset` and will work properly only under the Windows platform.
