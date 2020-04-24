library(tidyverse)

#load raw data
bike.df = as.tibble(read.csv( ".\\data\\bikeshare.csv", stringsAsFactors = FALSE))

#check data
head(bike.df)

#transform data
bike.df$type = ifelse(bike.df$type == 'casual','Casual',ifelse(bike.df$type == 'registered','Registered',bike.df$type))

bike.df <- gather(bike.df,key = 'type',value = 'TypeCount',casual,registered)
bike.df$season = ifelse(bike.df$season == 1,'Spring',ifelse(bike.df$season == 2,'Summer',ifelse(bike.df$season == 3,'Fall','Winter')))
bike.df$holiday = ifelse(bike.df$holiday == 1,'Holiday','Non-Holiday')
bike.df$hours = as.factor(substr(bike.df$datetime,12,13))
bike.df$type = as.factor(bike.df$type)
bike.df$season = as.factor(bike.df$season)
bike.df$holiday = as.factor(bike.df$holiday)
bike.df$date = as.Date(bike.df$datetime,'%Y-%m-%d')
bike.df$year = as.factor(format(bike.df$date, '%Y'))
bike.df$month = as.factor(format(bike.df$date, '%m'))
bike.df$season = relevel(bike.df$season ,"Winter","Spring","Summer", "Fall")
bike.df$workingday = as.factor(bike.df$workingday)
levels(bike.df$season)
levels(bike.df$year)
names(bike.df) <- str_to_title(names(bike.df))



bike.df %>%  filter(workingday == 1) %>% group_by(date,type) %>% summarise(total = sum(typecount,na.rm = T)) %>% 
             ggplot(aes(x = date, y = total)) + geom_bar(aes(fill = type), stat = 'identity',position = 'dodge')

group_by(bike.df,workingday) %>% summarise(sum(typecount,na.rm = T))

#Save processed data
f = write.csv(bike.df,".\\data\\processed_bike.csv",row.names = FALSE)
f = read.csv(".\\data\\processed_bike.csv",stringsAsFactors = F)
head(bike.df)

f %>% filter(year == '2012') %>% ggplot(aes(x = type,y=typecount))+geom_boxplot()

#Bike useage count per usertype
bike.df %>% group_by(type) %>% summarise(total = sum(typecount)) %>% 
            ggplot(aes(x = type, y = total)) + geom_bar(fill = 'red', stat = 'identity')

#Bike useage count per year and usertype
bike.df %>% group_by(year,type) %>% summarise(total = sum(typecount)) %>% 
  ggplot(aes(x = year, y = total)) + geom_bar(aes(fill = type), stat = 'identity', position = 'dodge')

##Bike useage count per usertype per season
bike.df %>% group_by(season,type) %>% summarise(total = sum(typecount)) %>% 
  ggplot(aes(x = season,y = total)) + geom_bar(aes(fill = type), stat="identity",position = 'dodge') +
  labs( title = "Bike Usage per Season per User Type",
        x = "Season", y = 'Total Count' )

#colnames(bike)
totalCount = sum(bike.df$typecount)
bike.df %>% group_by(season,type) %>% summarise(total = (sum(typecount)/totalCount)* 100) %>%  
  ggplot(aes(x = season,y = total)) + geom_bar(aes(fill = type), stat="identity", position = 'dodge') #facet_wrap()

bike.df %>% group_by(holiday,type) %>% summarise(total = sum(typecount)) %>% 
  ggplot(aes(holiday,total)) + geom_bar(aes(fill = type), stat="identity", position = 'dodge' )

bike %>% group_by(holiday,type) %>% summarise(total = sum(typecount)) %>% mutate(ratio = total/sum(total))
  ggplot(aes(holiday,total)) + geom_boxplot()

bike %>% group_by(holiday,type) %>% summarise(total = sum(typecount)) %>% 
  ggplot(aes(holiday,total)) + geom_density()

bike.df %>% group_by(type,hours) %>% summarise(total = sum(typecount)) %>%  #-> bikeHour
  ggplot(aes(x = hours,y = total)) + geom_bar(aes(fill = type), stat="identity",position = 'dodge') #+ facet_wrap(~season)

bike$date = strsplit()  bike$datetime 

ggplot(bike,aes(x = hours,y=count))+geom_line(stat ='identity') + geom_smooth(method = 'lm')






bike.df$season = levesl(ordered("Winter","Spring","Summer","Fall"))
levels(bike.df$season)
unique(bike$hours)
unique(substr(dt,12,13))
unique(bike$holiday)
as.Date(bike$datetime)
as.datetime(dt)
head(bike)
levels(bike.df$season)
top_n(bike,10)
bike.df[bike.df$datetime == '2012-12-19 01:00:00',]
sum(bike.df$holiday == 'Holiday')
