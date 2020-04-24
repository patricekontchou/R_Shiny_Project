
fluidPage(
  
  titlePanel('Washington D.C Bike Sharing Demand Analysis',windowTitle = ('Washington D.C')),
  sidebarLayout(
    sidebarPanel( 
      em(h4("This DropDown controls First and Third Tab.", align = 'left')),
      # br(),
      selectizeInput(inputId='year',label='Select a Year', 
                    choices = unique(bike.df$Year),
                    select=unique(bike.df$Year)
      ),
      em(h4("This DropDown controls Second Tab.", align = 'left'))
      ,
      
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
            column(6, h4("Plot of total bike used per each type of user per year.",align = 'center')),
            column(6, h4("Drilldown of usage for each type of user per season.", align = 'center')),
            column(6, plotOutput("usercount"),style='padding:00px;'),
            column(6, plotOutput("seasonYear"),style='padding:00px;'),
            column(12, h4("Box plot showing the distribution of usage for eatch type of usage per year.",align = 'center')),
            column(12, plotOutput("boxplot")),
            #column(6, plotOutput("year"))
            )
        ),
        
        # br(),
        # br(),
        # br(),
        # br(),
        
        tabPanel("Plot Per UserType", 
                 fluidRow(
                   br(),
                   column(6, h4("Plot of total bike used per each type of user per year.",align = 'center')),
                   column(6, h4("Drilldown of usage for each type of user per season.", align = 'center')),
                   column(6, plotOutput("seasonUser"),style='padding:20px;'),
                   column(6, plotOutput("userBoxplot"),style='padding:20px;'),
                   column(12, plotOutput("userHourly"),style='padding:30px;'),
                   #column(6, plotOutput("fall"))
                 )
        ),
        tabPanel("UserType Plot Combined",
                 br(),
                 column(12, h4("Plot of total bike used per each type of user per year.",align = 'center')),
                 column(12, plotOutput("seasonCombined"),style='padding:00px;'),
                 br(),
                 column(12, h4("Plot of total bike used per each type of user per year.",align = 'center')),
                 column(12, plotOutput("hourslyCombined"),style='padding:00px;')
                 
        )
        
        # tabPanel("About Me",
        #          textOutput("author"),
        # )
      ),
    )
  )
)