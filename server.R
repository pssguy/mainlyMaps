

shinyServer(function(input, output) {
  
  ## supermarket ui
  
  
  output$a <- renderUI({
    if (input$sbMenu=="supermarkets") {
      inputPanel(
      textInput("postcode","Enter Postcode","BR3 4DT"),
      submitButton(text="Apply Change",icon("refresh")) 
      )
    } else  if (input$sbMenu=="fortune") {
      
      inputPanel(
        sliderInput("count","Select Ranked Order",min=1,max=1000,value=c(1,1000),step=10, ticks=FALSE),
        uiOutput("industries")
      )
    } else {
      
    }
    
  })
  
 
  

  source("code/supermarkets.R", local=TRUE)
  source("code/prisons.R", local=TRUE)
  source("code/fortune500.R", local = TRUE)

})
