
fluidPage(
  
  titlePanel('Washington D.C Bike Sharing Demand Analysis',windowTitle = ('Washington D.C')),
  sidebarLayout(
    sidebarPanel( 
      
      #Text to indicate which tab the dropdown menu filter
      em(h5("This DropDown controls First and Third Tab.", align = 'left', style = "color:red")),
      
      #Dropdown menu for user inter-action
      selectizeInput(inputId='year',label='Select a Year', 
                    choices = unique(bike.df$Year),
                    select=unique(bike.df$Year)
                    ),
      #Text to indicate which tab the dropdown menu filter
      em(h5("This DropDown controls Second Tab.", align = 'left', style = "color:red")),
      
      #Dropdown menu for user inter-action
      selectizeInput(inputId='usertype',label=' Select a UserType',
                     choices =unique(bike.df$Type),
                     select=unique(bike.df$Type)[1]
                     ), width = 3
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot Per Year",
          fluidRow(
            br(),
            column(12, h4("Plots below compare bike risdeshare demand per user type across years. It can be seen that the \
                          distribution is consitent one year after the other.",align = 'left', style = "color:red")),
            column(6, plotOutput("usercount"), style='padding:20px;'),
            column(6, plotOutput("seasonYear"), style='padding:20px;'),
            column(12, plotOutput("boxplot")),
            )
        ),
        
        tabPanel("Plot Per UserType", 
                 fluidRow(
                   column(12, h4("Previous plots illustrated that risdeshare demand where consistent across both year. Knowing that, \
                    below plots analyze demand for each user type on both both year data combined.",align = 'left', style = "color:red")),
                   column(6, plotOutput("seasonUser"), style='padding:20px;'),
                   column(6, plotOutput("userBoxplot"),style='padding:20px;'),
                   column(12, plotOutput("userHourly"),style='padding:20px;'),
                 )
        ),
        tabPanel("UserType Plot Combined",
                 br(),
                 column(12, h4("Below plots analyze risdeshare demand per user type for each year.They reveal a consitent demand for each user \
                 per year, season and per hours.Based on this observation  can confirm demand pattern and can safely predict demand \
                 per hour and per season.",align = 'left', style = "color:red")),
                 column(12, plotOutput("seasonCombined"),style='padding:20px;'),
                 column(12, plotOutput("hourslyCombined"),style='padding:20px;')
                 
        )
        
        # tabPanel("About Me",
        #          textOutput("author"),
        # )
      ),
    )
  )
)