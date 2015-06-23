

library(leaflet)
library(readxl)
library(ggmap)
library(shiny)
library(shinydashboard)
library(choroplethr)
library(rgdal)
library(stringr)

## US states
maps <- readOGR(dsn=".",
                layer = "ne_50m_admin_1_states_provinces_lakes", 
                encoding = "UTF-8",verbose=FALSE)

#limit to US states and DC
states <-maps[50:100,] 

# create a stateID fore merging

states$stateId <-str_replace(states$iso_3166_2,"US-","")

## http://geolytix.co.uk/blog/tag/waitrose/ has supermarket locations

#so downloaded that


locations <- read_excel("./data/superLocations.xls")

# create a popup
# some of the fields have NA so replace with ""

locations[is.na(locations$Add2),]$Add2 <- ""
locations[is.na(locations$Locality),]$Locality <- ""
locations[is.na(locations$Town),]$Town <- ""

locations$popup <- sprintf("<table cellpadding='4' style='line-height:1'><tr>
                       <th>%1$s</th></tr>
                        <tr align='left'><td>%2$s</td></tr>
                        <tr align='left'><td>%3$s</td></tr>
                        <tr align='left'><td>%4$s</td></tr>
                        <tr align='left'><td>%5$s</td></tr>
                        <tr align='left'><td>%6$s</td></tr>
                        
                        </table>",
                        locations$Fascia,
                        locations$Add1,
                        locations$Add2,
                        locations$Locality,
                        locations$Town,
                        locations$Postcode)

exclude <- c("Costco","Dansk Supermarked","Whole Foods")
#locs <- locs[!locs$Retailer %in% exclude,]

locs <- locations %>% 
  data.frame(.) %>% 
  filter(!Retailer %in% exclude) %>% 
  select(Retailer,longitude=LongWGS84,latitude=LatWGS84, Fascia,popup)

retailerChoice <- sort(unique(locs$Retailer))

pal <- colorFactor("Paired", domain=NULL)

### prisons
prisons<- readRDS("./data/prisons.rds")


