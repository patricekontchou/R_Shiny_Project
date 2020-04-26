function(input,output) {
  
  ####### To feed the first tabPanel#####
  filter_year = reactive({
   bike.df %>% 
        filter(Year == input$year)
  
  })
  
  #Bike useage count per userType
  output$usercount = renderPlot({
    filter_year() %>% group_by(Type) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Type, y = Total)) + geom_bar(fill = 'red', stat = 'identity') +
      labs( title = "Bike Usage for each User Type per year.", 
            x = "User Type", y = 'Total Count' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  output$boxplot = renderPlot({
    filter_year() %>% 
      ggplot(aes(x = Type, y = Typecount)) + geom_boxplot(fill = 'red') +
      labs( title = "Box plot showing the distribution of usage for each User type.", 
            x = "User Type", y = 'Total Count' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  output$seasonYear = renderPlot({
    ##Bike useage count per userType per Season
    filter_year() %>% 
      group_by(Season,Type) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Season,y = Total), aes_string(colour = "blue")) + 
      geom_bar(aes(fill = Type), stat="identity",position = 'dodge') +
      labs( title = "Bike Usage per User Type per season.", 
            x = "Season", y = 'Total Count' ) +  
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  output$weather = renderPlot({
    filter_year() -> Weater.df
      group_by(Weater.df,Year,Season) %>% summarise(AvgT = mean(Temp,na.rm = T)) -> Weater.df
      ggplot(Weater.df,aes(Season,AvgT))+ geom_bar(fill = 'Red',stat = 'identity') +
      labs( title = "Average Temperature per season.", 
            x = "Season", y = 'Average Temperature' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  ####### To feed the second tabPanel#####
  filter_user = reactive({
    bike.df %>% 
      filter(Type==input$usertype) 
  })
  
  #Bike useage count per year and userType
  output$userBoxplot = renderPlot({
    filter_user() %>% 
      ggplot(aes(x = Season, y = Typecount)) + geom_boxplot(  fill = 'Green' ) +
      labs( title = "Bike usage distribution per user for both years combined.", 
            x = "Season", y = 'Total Count' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  output$seasonUser = renderPlot({
    filter_user() %>% group_by(Season) %>% summarise(Total = sum(Typecount)) %>%  
      ggplot(aes(x = Season,y = Total)) + geom_bar(fill = 'red', stat="identity")+
      labs( title = "Usage per user for each season both year combined.", 
            x = "Season", y = 'Total Count' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  ##Bike useage count per userType per Season
  output$userHourly = renderPlot({
    filter_user() %>% 
      group_by(Hours) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Hours,y = Total)) + geom_bar(fill = 'Red', stat="identity") +
      labs( title = "Usage per hour per user type.", 
          x = "Hours in 24 hours Format", y = 'Total Count' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  ####### To feed the second tabPanel#####
  output$seasonCombined = renderPlot({
    filter_year() %>% group_by(Season,Type,Hours) %>% summarise(Total = sum(Typecount)) %>%  
      ggplot(aes(x = Hours,y = Total)) + geom_bar(aes(fill = Type), stat="identity", position = 'dodge') + facet_wrap(~Season)+
      labs( title = "Bike usage per User type, per hour and per year for each season.", 
            x = "Hours in 24 hours Format", y = 'Total Count' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  output$hourslyCombined = renderPlot({
    filter_year() %>% group_by(Hours,Type) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Hours,y = Total)) + geom_bar(aes(fill = Type), stat="identity", position = 'dodge') +
      labs( title = "Bike usage per user type and  per hour and per year.", 
          x = "Hours in 24 hours Format", y = 'Total Count' ) + 
      theme(text=element_text(size=15),axis.text = element_text(colour = "blue"),
            #legend.title = element_text(color = "blue", size = 10,face = "bold"),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_discrete(name = "User Type")
  })
  
  # output$author = renderText({ "This app was designed and built by Patrice Kontchou.
  # Patrice is a Data Scientist fello at NYC Data Science Academy. Before Joining NYCDSA I graduated "
    # })
  
  
}