# The user-interface definition of the Shiny web app.
library(shiny)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
  navbarPage("Shiny app", 
             tabPanel("Mtcars data visualisation",
                      sidebarPanel(
                        sliderInput("mpg", 
                                    "Mpg:", 
                                    min = 10,
                                    max = 50,
                                    value = c(10, 50)),
                        sliderInput("hp", 
                                    "Hp",
                                    min = 30,
                                    max = 500,
                                    value = c(30, 500) 
                        ),
                        
                        uiOutput("carsControl"), 
                        actionButton(inputId = "clearAll", 
                                     label = "Clear selection", 
                                     icon = icon("square-o")),
                        actionButton(inputId = "selectAll", 
                                     label = "Select all", 
                                     icon = icon("check-square-o"))
                      ),
                      mainPanel(
                        dataTableOutput(outputId="dataTable")
                      )     
             ),
     
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("about.md")
                      )
             ) 
        )
  
  )