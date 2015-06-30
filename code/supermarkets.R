


location <- reactive({
  centre <- geocode(input$postcode)
  
  
  stores <- input$retailers
  
  info = list(lon = centre$lon,lat = centre$lat,stores = stores)
  
  return(info)
})

output$leafletMap <- renderLeaflet({
  print(input$postcode)
  
  if (is.null(input$postcode))
    return()
  
  #   print(glimpse(locs))
  #   print(unique(location()$stores))
  # put here as conflicted if in global?
  pal <- colorFactor("Paired", domain = NULL)
  #  print(pal)
  
  locs %>%
    group_by(Retailer) %>%
    filter(Retailer %in% location()$stores) %>%
    leaflet() %>%
    addTiles(options = tileOptions(opacity = 0.5)) %>%
    
    setView(location()$lon, location()$lat, zoom = 14) %>%
    #addCircles(color = ~pal(Retailer))
    addCircles(
      color = ~ pal(Retailer),radius = 25, popup =  ~ popup,opacity = 1
    ) %>%
    addLegend(pal = pal, values = ~ Retailer, opacity = 1)
  
})