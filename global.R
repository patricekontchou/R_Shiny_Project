#loading required libraries
library(shiny)
library(tidyverse)

#read pre-processed data
bike.df = read.csv('.\\data\\processed_bike.csv', stringsAsFactors = FALSE )

# No need to read the raw file since is pre-processed using bik_script
#bike.df = read.csv( ".\\data\\bikeshare.csv", stringsAsFactors = FALSE)

#inspect the structure of the loaded data
#str(bike.df)

#Convert required columns
bike.df$Hours = as.factor(bike.df$Hours)
bike.df$Type = as.factor(bike.df$Type)
bike.df$Season = as.factor(bike.df$Season)
bike.df$Holiday = as.factor(bike.df$Holiday)
bike.df$Year = as.factor(bike.df$Year)

#Take a peek in the read data to confirm tranformation
#str(bike.df)
#head(bike.df,3)

