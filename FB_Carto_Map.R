library(sf)

setwd("/Users/paulgoodship/Documents/Data Projects/Foodbank/GIS")
geojson_LAD <- "Local_Authority_Districts_December_2022_Boundaries_UK_BUC_143497700576642915.geojson"
geojson_CARTO <- "map02.geojson"

LAD <- st_read(geojson_LAD)
CARTO <- st_read(geojson_CARTO)

LAD <- LAD[,c(1,2)]
CARTO <- CARTO[,c(7,1)]

colnames(CARTO) <- colnames(LAD)

LAD_CRS <- st_crs(LAD)

target_crs <- st_crs(4326)

CARTO_NEW <- st_transform(CARTO, LAD_CRS)

CARTO_NEW$type <- "CARTO"
LAD$type <- "STANDARD"

st_crs(CARTO_NEW)

COMBINED <- rbind(LAD,CARTO_NEW)

shapefile_output <- "combined.shp"
st_write(COMBINED, shapefile_output)

class(geojson_data)
