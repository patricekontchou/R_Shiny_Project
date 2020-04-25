library(shiny)
library(tidyverse)
#library(leaflet)
#library(googleVis)

bike.df = read.csv('.\\data\\processed_bike.csv', stringsAsFactors = FALSE )
#bike.df = read.csv( ".\\data\\bikeshare.csv", stringsAsFactors = FALSE)
#head(bike.df,3)


bike.df$Hours = as.factor(bike.df$Hours)
bike.df$Type = as.factor(bike.df$Type)
bike.df$Season = as.factor(bike.df$Season)
bike.df$Holiday = as.factor(bike.df$Holiday)
#bike.df$Date = as.Date(bike.df$datetime,'%Y-%m-%d')
bike.df$Year = as.factor(bike.df$Year)
#bike.df$month = as.factor(format(bike.df$date, '%m'))
#bike.df$season = relevel(bike.df$season ,"Winter","Spring","Summer", "Fall")
#bike.df$workingday = as.factor(bike.df$workingday)

#unique(bike.df$Type)

#str(bike.df)
