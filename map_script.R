#Create leaflet map for wordpress web site 

#Read data for map
RELATO_participants <- read.csv("Registro MAPA - FILE PARA CARGAR.csv")


library(leaflet)
#choose provider:
#https://leaflet-extras.github.io/leaflet-providers/preview/

mapout <- leaflet(RELATO_participants) %>%  
  #Use satellite image as base  
  addProviderTiles("Stamen.Watercolor") %>%  
  #Add markers for organizations 
  addCircleMarkers(~ Longitude, ~ Latitude,
                   weight = 0.5,
                   col = 'blue', 
                   fillColor = 'blue3',
                   radius = 4, 
                   fillOpacity = 0.9, 
                   stroke = T, 
                   popup = paste0(
                     "<b>Institución: </b>"
                     , RELATO_participants$Institución
                     , "<br>"
                     , "<a href='"
                     , RELATO_participants$url
                     , "' target='_blank'>"
                     , "Sitio Web</a>"
                   )) %>% 
  setView(lat =-25.533291, lng =-60.316388, zoom = 2)


greencircle = makeIcon("https://www.freeiconspng.com/uploads/green-circle-icon-28.png", iconWidth = 15, iconHeight =15)
redcircle = makeIcon("https://www.freeiconspng.com/uploads/red-circle-icon-1.png", iconWidth = 15, iconHeight =15)

mapout2 <- leaflet(RELATO_participants) %>%  
  #Use satellite image as base  
  addProviderTiles("Stamen.Watercolor") %>%  
  #Add markers for organizations 
  addMarkers(~ Longitude, ~ Latitude,clusterOptions = markerClusterOptions(),icon=redcircle,popup = paste0(
    "<b>Institución: </b>"
    , RELATO_participants$Institución
    , "<br>"
    , "<a href='"
    , RELATO_participants$url
    , "' target='_blank'>"
    , "Sitio Web</a>"
  )) %>% 
  setView(lat =-25.533291, lng =-60.316388, zoom = 2)%>% 
addLabelOnlyMarkers(data = RELATO_participants,
                    lng = ~Longitude, lat = ~Latitude,
                    clusterOptions = markerClusterOptions(),
                    labelOptions = labelOptions(noHide = T,direction = "auto"))


#Export > Save as Web page.

#add iframe in your web site after uploading the html file somewhere
#example:
#<iframe src="https://relatoceano.org/wp-content/uploads/2020/11/mapa_web.html" frameborder="0" width="100%" height="500px"></iframe>

#source
#https://learn.r-journalism.com/en/mapping/leaflet_maps/leaflet/
