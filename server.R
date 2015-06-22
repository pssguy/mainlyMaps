

shinyServer(function(input, output) {
  
  ## supermarket ui
  
  
  output$a <- renderUI({
    if (input$sbMenu=="supermarkets") {
      inputPanel(
      textInput("postcode","Enter Postcode","BR3 4DT"),
      submitButton(text="Apply Change",icon("refresh")) 
      )
    } else {
     
    }
    
  })
  
 
  

  source("code/supermarkets.R", local=TRUE)

})
