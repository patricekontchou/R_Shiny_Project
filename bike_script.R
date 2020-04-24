library(tidyverse)

#load raw data
bike.df = as.tibble(read.csv( ".\\data\\bikeshare.csv", stringsAsFactors = FALSE))

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
levels(bike.df$season)
levels(bike.df$year)
names(bike.df) <- str_to_title(names(bike.df))



bike.df %>%  filter(Workingday == 1) %>% group_by(Date,Type) %>% summarise(Total = sum(Typecount,na.rm = T)) %>% 
  ggplot(aes(x = Date, y = Total)) + geom_bar(aes(fill = Type), stat = 'identity',position = 'dodge')

group_by(bike.df,Workingday) %>% summarise(sum(Typecount,na.rm = T))

#Save processed data
write.csv(bike.df,".\\data\\processed_bike.csv",row.names = FALSE)
f = read.csv(".\\data\\processed_bike.csv",stringsAsFactors = F)
head(bike.df)



#Bike useage count per usertype
bike.df %>% group_by(type) %>% summarise(Total = sum(TypeCount)) %>% 
  ggplot(aes(x = type, y = Total)) + geom_bar(fill = 'red', stat = 'identity')

#Bike useage count per year and usertype
bike.df %>% group_by(year,type) %>% summarise(Total = sum(TypeCount)) %>% 
  ggplot(aes(x = year, y = Total)) + geom_bar(aes(fill = type), stat = 'identity', position = 'dodge')

##Bike useage count per usertype per season
bike.df %>% group_by(season,type) %>% summarise(Total = sum(TypeCount)) %>% 
  ggplot(aes(x = season,y = Total)) + geom_bar(aes(fill = type), stat="identity",position = 'dodge') +
  labs( title = "Bike Usage per Season per User Type",
        x = "Season", y = 'Total Count' )

#colnames(bike)
TotalCount = sum(bike.df$TypeCount)
bike.df %>% group_by(season,type) %>% summarise(Total = (sum(TypeCount)/TotalCount)* 100) %>%  
  ggplot(aes(x = season,y = Total)) + geom_bar(aes(fill = type), stat="identity", position = 'dodge') #facet_wrap()

bike.df %>% group_by(holiday,type) %>% summarise(Total = sum(TypeCount)) %>% 
  ggplot(aes(holiday,Total)) + geom_bar(aes(fill = type), stat="identity", position = 'dodge' )

bike %>% group_by(holiday,type) %>% summarise(Total = sum(TypeCount)) %>% mutate(ratio = Total/sum(Total))
ggplot(aes(holiday,Total)) + geom_boxplot()

bike %>% group_by(holiday,type) %>% summarise(Total = sum(TypeCount)) %>% 
  ggplot(aes(holiday,Total)) + geom_density()

bike.df %>% group_by(type,hours) %>% summarise(Total = sum(TypeCount)) %>%  #-> bikeHour
  ggplot(aes(x = hours,y = Total)) + geom_bar(aes(fill = type), stat="identity",position = 'dodge') #+ facet_wrap(~season)

bike$date = strsplit()  bike$datetime 

ggplot(bike,aes(x = hours,y=count))+geom_line(stat ='identity') + geom_smooth(method = 'lm')



# bike.df$hours = ifelse(bike.df$hours == '0','12 AM',ifelse(bike.df$hours == '1','1 AM',ifelse(bike.df$hours= '2','2 AM', \
#                 ifelse(bike.df$hours == '3','3 AM',ifelse(bike.df$hours == '4','4 AM',ifelse(bike.df$hours == '5','5 AM', ifelse(bike.df$hours == '6','6 AM',
# ifelse(bike.df$hours == ))))))))  


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
