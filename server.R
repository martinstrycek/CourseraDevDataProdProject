library(shiny)
library(datasets)
require(data.table)
require(devtools)

cars <- sort(rownames(mtcars))
carsData <<- mtcars
setDT(carsData, keep.rownames = TRUE)[]

shinyServer(
  function(input, output) {
    
    # Initialize reactive values
    values <- reactiveValues()
    values$cars <- cars
    
    # cars names inputs
    output$carsControl <- renderUI({
      checkboxGroupInput('cars', 'Cars list:', 
                         cars, selected = values$cars)
    })
    
    # Select All
    observe({
      if(input$selectAll == 0) return()
      values$cars <- cars
    })
    
    # Clear All
    observe({
      if(input$clearAll == 0) return()
      values$cars <- c() # empty list
    })
    
    # data set filtering
    dataTable <- reactive({
      filter(carsData, input$hp[1] < carsData$hp & carsData$hp < input$hp[2] & input$mpg[1] < carsData$mpg & carsData$mpg < input$mpg[2] & carsData$rn %in% input$cars )
    })
    
    output$dataTable <- renderDataTable({
      dataTable()
    }
    )
  }
)