
output$prospectsMap <- renderLeaflet({
prospects %>% 
  filter(Commitment=="Florida State") %>% 
  leaflet() %>% 
  addTiles() %>% ##? no map
  addCircleMarkers( color = ~binpal(rank), opacity=0.9, radius=5) %>% 
  addLegend(pal=binpal,values= ~rank, position='bottomleft', title="Category")
})