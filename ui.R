
fluidPage(
  
  titlePanel('Washington D.C Bike Sharing Demand Analysis',windowTitle = ('Washington D.C')),
  sidebarLayout(
    sidebarPanel( 
      selectizeInput(inputId='year',label='Select a Year',
                    choices = unique(bike.df$Year),
                    select=unique(bike.df$Year)
      ),
      
      selectizeInput(inputId='usertype',label=' Select a UserType',
                     choices =unique(bike.df$Type),
                     select=unique(bike.df$Type)[1]
                     ), width = 3
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot Per Year",
          fluidRow(
            column(6, plotOutput("usercount")),
            column(6, plotOutput("seasonYear")),
            column(12, plotOutput("boxplot")),
            #column(6, plotOutput("year"))
            )
        ),
        tabPanel("Plot Per UserType", 
                 fluidRow(
                   column(6, plotOutput("seasonUser")),
                   column(6, plotOutput("userBoxplot")),
                   column(12, plotOutput("userHourly")),
                   #column(6, plotOutput("fall"))
                 )
        ),
        tabPanel("UserType Plot Combined",
                 column(12, plotOutput("seasonCombined")),
                 column(12, plotOutput("hourslyCombined"))
                 
        ),
        
        tabPanel("About Me",
                 textOutput("author")
        )
      ),
    )
  )
)