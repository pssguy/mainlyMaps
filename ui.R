

dashboardPage(
  skin = "green",
  dashboardHeader(title = "Mainly Maps"),
  
  dashboardSidebar(
    includeCSS("custom.css"),
    
    #       fluidRow(column(width=8,textInput("postcode","Enter Postcode","BR3 4DT")),
    #                column(width=4, submitButton(icon("refresh")))
    #       ),
    
    #    textInput("postcode","Enter Postcode","BR3 4DT"),
    #     submitButton(text="Apply Change",icon("refresh")),
    uiOutput("a"),
    hr(),
    
    sidebarMenu(
      id = "sbMenu",
      
      menuItem(
        "Fortune 1000 HQs", tabName = "fortune",icon = icon("map-marker")
      ),
      menuItem(
        "UK Supermarkets", tabName = "supermarkets",icon = icon("map-marker")
      ),
      menuItem(
        "US Prisons", tabName = "prisons",icon = icon("map-marker")
      ),
      
      #   menuItem("Data", tabName = "data",icon = icon("database")),
      menuItem("Info", tabName = "info",icon = icon("info")),
      #
      #   menuItem("Code",icon = icon("code-fork"),
      #            href = "https://github.com/pssguy/fortune500"),
      #
      menuItem(
        "Other Dashboards",
        
        menuSubItem("MLB",href = "https://mytinyshinys.shinyapps.io/mlbCharts"),
        menuSubItem("Climate",href = "https://mytinyshinys.shinyapps.io/climate"),
        menuSubItem("WikiGuardian",href = "https://mytinyshinys.shinyapps.io/wikiGuardian"),
        menuSubItem("World Soccer",href = "https://mytinyshinys.shinyapps.io/worldSoccer")
      ),
      
      menuItem("", icon = icon("twitter-square"),
               href = "https://twitter.com/pssGuy"),
      
      menuItem("", icon = icon("envelope"),
               href = "mailto:agcur@rogers.com")
    )
  ),
  
  dashboardBody(tabItems(
    tabItem(
      "supermarkets",
      
      
      box(
        width = 12,
        status = "success", solidHeader = TRUE,
        title = "Amend Post code and Supermarket selection as desired - click circle for address",
        checkboxGroupInput(
          "retailers","Select Retailers",retailerChoice, selected = retailerChoice, inline = TRUE
        ),
        leafletOutput('leafletMap',height = 550)
        
      )
    ),
    tabItem(
      "prisons",
      
      
      box(
        width = 6,
        status = "success", solidHeader = TRUE,
        title = "Prisons. Click on circle for Prison Name",
        
        leafletOutput('prisonsLeaflet',height = 450)
        
      ),
      box(
        width = 6,
        status = "success", solidHeader = TRUE,
        title = "Prisons. Click on state for more information",
        
        leafletOutput('prisonsChoropleth',height = 450)
        
      )
    ),
    tabItem("fortune",
            fluidRow(
              tabBox(
                
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "tabset1", height = "500px",
                tabPanel("Choropleth Click State for Table",
                         leafletOutput("choropleth")),
                tabPanel("Locations. Click for Details",
                         leafletOutput("locations")),
                
                tabPanel("HexBins",
                         statebinOutput("statebins"))
              ),
              
              box(
                width = 6, status = "success", solidHeader = TRUE,
                title = "Leading Companies within State - Use with Choropleth",
                DT::dataTableOutput("table")
                
              )
            )
    ),
    # tabItem("data",
    #           fluidRow(
    #             column(width=8,offset=2,
    #
    #           box(width=12,
    #             status = "info", solidHeader = FALSE,
    #             includeMarkdown("data.md")
    #           ),
    #           box(width=12,
    #             DT::dataTableOutput("data")
    #           )
    #             ))
    #         ),
    #
    tabItem("info",includeMarkdown("info.md"))
    
  ))
)
