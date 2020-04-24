function(input,output) {
  
  ####### To feed the first tabPanel#####
  filter_year = reactive({
    if ( input$year == 'All' ){
      bike.df
      
    } else{
      bike.df %>% 
        filter(Year == input$year)
    }
  })
  
  #Bike useage count per userType
  output$usercount = renderPlot({
    filter_year() %>% group_by(Type) %>% summarise(total = sum(Typecount)) %>% 
      ggplot(aes(x = Type, y = total)) + geom_bar(fill = 'red', stat = 'identity')
  })
  
  output$SeasonYear = renderPlot({
    ##Bike useage count per userType per Season
    filter_year() %>% group_by(Season,Type) %>% summarise(total = sum(Typecount)) %>% 
      ggplot(aes(x = Season,y = Total)) + geom_bar(aes(fill = Type), stat="identity",position = 'dodge') +
      labs( title = "Bike Usage per Season per User Type",
            x = "Season", y = 'Total Count' )
  })
  
  output$boxplot = renderPlot({
    filter_year() %>% #group_by(Type) %>% #summarise(total = sum(Typecount)) %>% 
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
  
  output$SeasonUser = renderPlot({
    filter_user() %>% summarise(TotalCount = sum(Typecount)) -> count.df
      
    filter_user() %>% group_by(Season) %>% summarise(total = sum(Typecount)) %>%  
      ggplot(aes(x = Season,y = Total)) + geom_bar(fill = 'red', stat="identity")
  })
  
  output$userHourly = renderPlot({
    ##Bike useage count per userType per Season
    filter_user() %>% group_by(Hours) %>% summarise(total = sum(Typecount)) %>% 
      ggplot(aes(x = Hours,y = Total)) + geom_bar(fill = 'Red', stat="identity") +
      labs( title = "Bike Usage per Season per User Type",
            x = "Season", y = 'Total Count' )
  })
  
  
  output$SeasonCombined = renderPlot({
    filter_year() %>% summarise(totalCount = sum(Typecount)) -> count.df
    
    filter_year() %>% group_by(Season,Type) %>% summarise(total = sum(Typecount)) %>%  
      ggplot(aes(x = Season,y = Total)) + geom_bar(aes(fill = Type), stat="identity", position = 'dodge')
  })
  
  output$hourslyCombined = renderPlot({
    ##Bike useage count per userType per Season
    filter_year() %>% group_by(Hours,Type) %>% summarise(Total = sum(Typecount)) %>% 
      ggplot(aes(x = Hours,y = Total)) + geom_bar(aes(fill = Type), stat="identity", position = 'dodge') +
      labs( title = "Demand Per Year For both UserType.",
            x = "Hours", y = 'Total Count' )
  })
  
  output$author = renderText({ " About the author: This is the " 
    
    
    })
  
  
}