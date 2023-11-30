library(shiny)
library(shinydashboard)
library(leaflet)
library(magrittr)
library(raster)
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
      title=("Creating a hazard curve for tephra fall"), width = 10,
      downloadButton("torisetsu","取扱説明書・日本語版のダウンロード"),
      tags$br(),
      tags$br(),
      h4(" STEP1. Find coordinates at a locality clicking on the map"),
      leafletOutput("mymap"),
      h5(" *Some tephra fall distribution maps can be seen, switching on and off at a layer controller."),
      h5(" You can get coordinates below when you click on the map:"),
      tableOutput("loc"),
      
      tags$hr(),
      h4(" STEP2. Input coordinates and push the button to create a hazard curve!"),
       textInput("lat1", "Latitude", ""),
       textInput("long1", "Longitude", ""),
       actionButton("goAction", "Create a hazard curve!"),
       h5(" Please wait for a few minutes to obtain a hazard curve."),
      
      tags$hr(),
      h4(" STEP3. The calculated result."),
           tabsetPanel(
           tabPanel("Plot", plotOutput("plot1")),
           tabPanel("Table 1: Data of the hazard curve",
                    tags$br(),
                    downloadButton("downloadData1","Download the result"),
                    actionButton("goAction2", "View the table"),
                    tableOutput("haz")),
           tabPanel("Table 2: The tephra fall history",
                    tags$br(),
                    downloadButton("downloadData2","Download the result"),
                    actionButton("goAction3", "View the table"),
                    tableOutput("hist")
           )
           ),
      tags$footer(
        HTML("&copy;"),"Central Research Institute of Electric Power Industry"
         )  
      )
      )
    ),
  
  tabItem(tabName = "database",
          tags$html(
            tags$body(title = "Database"),
            tags$b("1 ka = 1,000 years before present")
            ),
          
          tabPanel("Tephra DB", 
                   tableOutput("tephraDB"))
          ),
  
  tabItem(tabName = "readme",
          tabPanel("Readme", 
                  tags$html(
                    tags$body(
                      title="README", 
                      tags$br("Update: <30/Nov/2023>　version: v1.3.1"),
                      tags$br(),
                      tags$html("We created this GUI program for assessing tephra fall hazards based on a database of Isopach maps (prototype version) by Shimpei Uesawa using R-Shiny with R-studio.
                                The original script and source data are available at"),
                      tags$a("https://github.com/s-uesawa/Prototype-TephraDB-Japan", href="https://github.com/s-uesawa/Prototype-TephraDB-Japan"),
                      tags$html("and"),
                      tags$a("https://doi.org/10.5281/zenodo.7857457", href="https://doi.org/10.5281/zenodo.7857457"), tags$br(), 
                      tags$html("See Uesawa et al. (2022)"), tags$a("https://doi.org/10.1186/s13617-022-00126-x", href="https://doi.org/10.1186/s13617-022-00126-x"), tags$html("for a detailed explanation."), tags$br(),
                      tags$br("Present and previous versions of this application source codes are available at"), tags$a("https://github.com/s-uesawa/IB-THA-GUI", href="https://github.com/s-uesawa/IB-THA-GUI"),tags$br(),
                      tags$br("The coordinate ranges handled in this database are as follows:"),
                      tags$text("125E/150E/25N/47N (JGD2000)"), tags$br(),
                      tags$br("R is a free software environment for statistical computation and graphics. (Visit"),
                      tags$a("https://www.r-project.org/", href="https://www.r-project.org/"), tags$html("for more detail)"),
                      tags$br(),
                      tags$br("Author: Shimpei Uesawa (contact: uesawa<at>criepi.denken.or.jp) <at> -> @"),
                      tags$text("Affiliation: Central Research Institute of Electric Power Industry, Nuclear Risk Research Center, Abiko, Chiba, Japan"),
                      tags$br(),
                      tags$br("Source Code License: GPL. You can use it at your own risk."),
                      tags$br("Disclaimers; CRIEPI and the author, the original data acquirer/creator, and the database administrator shall not be held liable for any loss or damage arising from using this database."),
                      tags$br("All rights reserved @ CRIEPI, Japan."),
                      tags$br()
                    ))
          ,
                  tags$a(rel="license", href="http://creativecommons.org/licenses/by/4.0/", tags$img(alt="Creative Commons License", style="border-width:0", src="https://i.creativecommons.org/l/by/4.0/88x31.png")), tags$br(), tags$a(rel="license", href="http://creativecommons.org/licenses/by/4.0/", "This work is licensed under a Creative Commons Attribution 4.0 International License.")
                  
  )
  )
)
)
)
)


