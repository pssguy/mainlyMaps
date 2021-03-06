# Not a shiny app so no functions required currently


lMap <-  prisons %>%
  select(lat,lon,facility_name) %>%
  leaflet() %>%
  addTiles() %>%
  clearBounds() %>%
  addCircles(popup =  ~ facility_name)

output$prisonsLeaflet <- renderLeaflet(lMap)



data(df_pop_state)
print(glimpse(df_pop_state))

summary <- prisons %>%
  group_by(state) %>%
  
  tally() %>%
  mutate(region = tolower(state)) %>%
  #inner_join(df_pop_state, by=c("state"="region")) %>%
  inner_join(df_pop_state) %>%
  mutate(ppm = round(n * 1000000 / value,1)) %>%
  select(state,count = n,state,ppm)

summary <- data.frame(summary)

states2  <- sp::merge(states,
                      summary,
                      by.x = "name",
                      by.y = "state",
                      sort = FALSE)
print(names(states2))
# add a popup field
states2$popUp <-
  paste0(
    "<strong>",states2$name,"</strong><br>Prisons: ",states2$count,
    "<br>per Million: ",states2$ppm
  )

print(states2$popUp)

# create colors with domain ranging to highest value
pal <- colorNumeric("Reds", c(0,max(states2$ppm,na.rm = T)))

# create leaflet map
cMap <-  leaflet(data = states2) %>%
  addTiles() %>%
  setView(-110,38,zoom = 3) %>%
  addPolygons(
    fillColor = ~ pal(ppm),
    fillOpacity = 0.6,
    color = "#BDBDC3",
    weight = 1,
    #layerId = ~State,
    popup = ~ popUp
  ) %>%
  mapOptions(zoomToLimits = "first") %>%
  addLegend(
    pal = pal, values = ~ ppm, position = "bottomleft", title = "Prisons per Million"
  )

output$prisonsChoropleth <- renderLeaflet(cMap)
