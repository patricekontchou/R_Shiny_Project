function(input,output) {
  
  ####### To feed the first tabPanel#####
  filter_year = reactive({
   bike.df %>% 
        filter(Year == input$year)
  
  })
  
  #Bike useage count per userType
  output$usercount = renderPlot({
    filter_year() %>% group_by(Type) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Type, y = Total)) + geom_bar(fill = 'red', stat = 'identity')
  })
  
  output$seasonYear = renderPlot({
    ##Bike useage count per userType per Season
    filter_year() %>% 
      group_by(Season,Type) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Season,y = Total)) + geom_bar(aes(fill = Type), stat="identity",position = 'dodge') +
      labs( title = "Bike Usage per Season per User Type",
            x = "Season", y = 'Total Count' )
  })
  
  output$boxplot = renderPlot({
    filter_year() %>% 
      ggplot(aes(x = Type, y = Typecount)) + geom_boxplot(fill = 'red')
  })
  
  ####### To feed the second tabPanel#####
  filter_user = reactive({
    bike.df %>% 
      filter(Type==input$usertype) 
  })
  
  output$userBoxplot = renderPlot({
    #Bike useage count per year and userType
    filter_user() %>% 
      ggplot(aes(x = Season, y = Typecount)) + geom_boxplot(  fill = 'Green' )
  })
  
  output$seasonUser = renderPlot({
    # filter_user() %>% 
    #   summarise(TotalCount = sum(Typecount)) -> count.df
      
    filter_user() %>% group_by(Season) %>% summarise(Total = sum(Typecount)) %>%  
      ggplot(aes(x = Season,y = Total)) + geom_bar(fill = 'red', stat="identity")
  })
  
  output$userHourly = renderPlot({
    ##Bike useage count per userType per Season
    filter_user() %>% 
      group_by(Hours) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Hours,y = Total)) + geom_bar(fill = 'Red', stat="identity") +
      labs( title = "Bike Usage per Season per User Type",
            x = "Season", y = 'Total Count' )
  })
  
  
  output$seasonCombined = renderPlot({
    #filter_year() %>% summarise(TotalCount = sum(Typecount)) -> count.df
    
    filter_year() %>% group_by(Season,Type) %>% summarise(Total = sum(Typecount)) %>%  
      ggplot(aes(x = Season,y = Total)) + geom_bar(aes(fill = Type), stat="identity", position = 'dodge')
  })
  
  output$hourslyCombined = renderPlot({
    ##Bike useage count per userType per Season
    filter_year() %>% group_by(Hours,Type) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Hours,y = Total)) + geom_bar(aes(fill = Type), stat="identity", position = 'dodge') +
      labs( title = "Demand Per Year For both UserType.",
            x = "Hours", y = 'Total Count' )
  })
  
  # output$author = renderText({ "This app was designed and built by Patrice Kontchou.
  # Patrice is a Data Scientist fello at NYC Data Science Academy. Before Joining NYCDSA I graduated "
    # })
  
  
}