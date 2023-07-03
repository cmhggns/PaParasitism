# Load required packages
library(ggplot2)
library(maps)
library(sp)
library(mapdata)
library(spData)
library(ggspatial)
library(sf)

# download and unzip shapefiles from data.govt.nz
# lake polygon url: https://data.linz.govt.nz/layer/50293-nz-lake-polygons-topo-150k/
# river polygon url: https://data.linz.govt.nz/layer/50328-nz-river-polygons-topo-150k/

# Read unzipped shp files
nzlakes <- st_read(dsn = "F:/Pant_DE/lds-new-zealand-2layers-SHP/nz-lake-polygons-topo-150k")
nzrivers <- st_read(dsn = "F:/Pant_DE/lds-new-zealand-2layers-SHP/nz-river-polygons-topo-150k")

# This makes a basic map of NZ, using the shapefiles you unzipped
nzwater <- ggplot() +
  geom_sf(data=nz) +
  geom_sf(data=nzlakes, color="skyblue4") +
  geom_sf(data=nzrivers, color = "skyblue3") +
  annotation_scale(location="br") +
  annotation_north_arrow(location="tl") +
  theme(panel.background = element_rect(fill = "skyblue2", color = "skyblue2", linetype = "solid"))

# Make a df with sampling coordinates and then convert the df into a shapefile
sampling <- data.frame(lon = c(170.460260, 171.127667, 171.518647),
                       lat = c(-43.936736, -42.806435, -43.243705),
                       Name = c("Lake Alexandrina", "Lake Kaniere", "Lake Selfe"))
sample_sf <- st_as_sf(sampling, coords = c("lon", "lat"), crs = 4326)
sample_sf

# Make a new map with your sample coordinate shapefile added
nzwater + geom_sf(data=sample_sf, color="red")
