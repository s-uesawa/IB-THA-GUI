library(shiny)
library(shinydashboard)
library(leaflet)
library(magrittr)
library(raster)
library(rgdal)
library(sp)

shinyUI(
  dashboardPage(skin="blue",
  dashboardHeader(title="IB-THA"),
  dashboardSidebar(title="Menu",
                  sidebarMenu(
                    menuItem("Creating a hazard curve", tabName="hazardcurve", icon=icon("dashboard")),
                    menuItem("Table of the database", tabName="database", icon=icon("th")),
                    menuItem("Readme", tabName="readme", icon=icon("home"))
                  )
  ),
  
  dashboardBody(
    tags$head(
    tags$link(rel="stylesheet", type = "text/css", href="www/custom.css")
    ),
    tabItems(
    tabItem(tabName = "hazardcurve",
            
  fluidRow(
    box(
      title=("Creating a hazard curve"), width = 10,
      h4(" STEP1. Find coordinates at a locality clicking on the map"),
      leafletOutput("mymap"),
      h5(" *Representative tephra fall distributions can be seen, switching on and off at a layer controller. Minimum limit of the displaying thickness is 10 mm."),
      h5(" You can get coordinates below when you click on the map:"),
      tableOutput("loc"),
      
      tags$hr(),
      h4(" STEP2. Input coordinates and push the button to create a hazard curve!"),
       textInput("lat1", "Latitude(lat)", ""),
       textInput("long1", "Longitude(lng)", ""),
       actionButton("goAction", "Create a hazard curve!"),
      
      tags$hr(),
      h4(" STEP3. The calculated result."),
           tabsetPanel(
           tabPanel("Plot", plotOutput("plot1")),
           tabPanel("Table",
                    tags$br(),
                    downloadButton("downloadData1","Download the result"),
                    tableOutput("haz")
           )
           )
      )
    )
    )
  ,
  
  tabItem(tabName = "database",
          tabPanel("Tephra DB", 
                   tableOutput("tephraDB"))
          ),
  
  tabItem(tabName = "readme",
          tabPanel("Readme", 
                  tableOutput("readMe"),
                  tags$a(rel="license", href="http://creativecommons.org/licenses/by/4.0/", tags$img(alt="Creative Commons License", style="border-width:0", src="https://i.creativecommons.org/l/by/4.0/88x31.png")), tags$br(), tags$a(rel="license", href="http://creativecommons.org/licenses/by/4.0/", "This work is licensed under a Creative Commons Attribution 4.0 International License.")
                  
  )
  )
)
)
)
)


