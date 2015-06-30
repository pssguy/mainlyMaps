


output$fortune_data <- DT::renderDataTable({
  fortune %>%
    
    DT::datatable(rownames = FALSE)
})