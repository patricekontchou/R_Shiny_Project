library(tidyverse)

#load raw data
bike.df = as_tibble(read.csv( ".\\data\\bikeshare.csv", stringsAsFactors = FALSE))

#check data
head(bike.df)

#transform data
bike.df <- gather(bike.df,key = 'type',value = 'Typecount',casual,registered)

bike.df$type = ifelse(bike.df$type == 'casual','Casual',ifelse(bike.df$type == 'registered','Registered',bike.df$type))

bike.df$season = ifelse(bike.df$season == 1,'Spring',ifelse(bike.df$season == 2,'Summer',ifelse(bike.df$season == 3,'Fall','Winter')))

bike.df$holiday = ifelse(bike.df$holiday == 1,'Holiday','Non-Holiday')

bike.df$hours = substr(bike.df$datetime,12,13)


bike.df$hours = as.factor(bike.df$hours)

bike.df$type = as.factor(bike.df$type)

bike.df$season = as.factor(bike.df$season)

bike.df$holiday = as.factor(bike.df$holiday)

bike.df$date = as.Date(bike.df$datetime,'%Y-%m-%d')

bike.df$year = as.factor(format(bike.df$date, '%Y'))

bike.df$month = as.factor(format(bike.df$date, '%m'))

bike.df$season = relevel(bike.df$season ,"Winter","Spring","Summer", "Fall")

bike.df$workingday = as.factor(bike.df$workingday)

#Capitalize columns names
names(bike.df) <- str_to_title(names(bike.df))

#reordering season to go from winter to fall to mimic Jan - Dec calendar year
bike.df$Season = factor(bike.df$Season, levels = c("Winter","Spring","Summer","Fall"))


#Save processed data with only needed columns
bike.df = select(bike.df,-Atemp,-Humidity,-Windspeed)
write.csv(bike.df,".\\data\\processed_bike.csv",row.names = FALSE)

head(bike.df)


######## Anlaysis draft############

#Bike useage count per usertype
bike.df %>% group_by(Type) %>% summarise(Total = sum(Typecount)) %>% 
  ggplot(aes(x = Type, y = Total)) + geom_bar(fill = 'red', stat = 'identity')

#Bike useage count per year and usertype
bike.df %>% group_by(Year,Type) %>% summarise(Total = sum(Typecount)) %>% 
  ggplot(aes(x = Year, y = Total)) + geom_bar(aes(fill = Type), stat = 'identity', position = 'dodge')

##Bike useage count per usertype per season
bike.df %>% group_by(Season,Type) %>% summarise(Total = sum(Typecount)) %>% 
  ggplot(aes(x = Season,y = Total)) + geom_bar(aes(fill = Type), stat="identity",position = 'dodge') +
  labs( title = "Bike Usage per Season per User Type",
        x = "Season", y = 'Total Count' )

#Plot Holidays vs Non-Holidays
bike.df %>% group_by(Holiday,Type) %>% summarise(Total = sum(Typecount)) %>% 
  ggplot(aes(Holiday,Total)) + geom_bar(stat="identity")

#hourly plots per user type
bike.df %>% group_by(Type,Hours) %>% summarise(Total = sum(Typecount)) %>%  #-> bikeHour
  ggplot(aes(x = Hours,y = Total)) + geom_bar(aes(fill = Type), stat="identity",position = 'dodge') #+ facet_wrap(~season)



# Average temperature vs average count per day to simulate lidear regression model. 
bike.df %>% group_by(Date,Type) %>% summarise(AvgT = mean(Temp), AvgC = mean(Typecount))  -> dateg2
  ggplot(dateg2,aes(x =AvgT,y= AvgC) ) + geom_point(aes(color = Type,geom="line"), stat = 'identity') + 
  geom_smooth(aes(color = Type), method = 'lm')

