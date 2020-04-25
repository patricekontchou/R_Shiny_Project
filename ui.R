
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
            column(12, h4("This tab compares bike usage per user type across years. It can be seen that the \
                          distribution is consitent one year after the other.",align = 'center', style = "color:red")),
            column(6, plotOutput("usercount"), style='padding:20px;'),
            column(6, plotOutput("seasonYear"), style='padding:20px;'),
            column(12, plotOutput("boxplot")),
            )
        ),
        
        tabPanel("Plot Per UserType", 
                 fluidRow(
                   br(),
                   column(12, h4("Plot of total bike used per each type of user per year.",align = 'center')),
                   column(6, plotOutput("seasonUser"), style='padding:20px;'),
                   column(6, plotOutput("userBoxplot"),style='padding:20px;'),
                   column(12, plotOutput("userHourly"),style='padding:20px;'),
                 )
        ),
        tabPanel("UserType Plot Combined",
                 br(),
                 column(12, h4("Plot of total bike used per each type of user per year.",align = 'center')),
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