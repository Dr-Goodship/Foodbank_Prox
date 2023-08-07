# Load required package
library(jsonlite)

# Set URL
url2 <- "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Authority_Districts_December_2022_Boundaries_UK_BGC/FeatureServer/0/query?where=1%3D1&outFields=LAD22CD,LAD22NM,BNG_E,BNG_N,LONG,LAT&outSR=4326&f=json"

# Download data from URL
data2 <- jsonlite::fromJSON(url2)

# Convert data to data frame
df2 <- as.data.frame(data$features$attributes)


#
#
#


#get the LAD name data
url2 <- "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Authority_Districts_December_2022_UK_BGC_V2/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson"

# Download data from URL
data2 <- jsonlite::fromJSON(url2)

# Convert data to data frame
df2 <- as.data.frame(data2$features$properties)


#
#
#


DF3 <- merge(df,df2,
      by.x = "...1", by.y = "LAD22NM",
      all.x = TRUE)

# get hexMap from https://open-innovations.org/projects/hexmaps/builder.html?maps/uk-local-authority-districts-2021.hexjson
# LAD 2021

hex <- "/Users/paulgoodship/Documents/Data Projects/Foodbank/GIS/map02.geojson"
hexMap_geoJSON <- fromJSON(hex)

hexMap <- as.data.frame(hexMap_geoJSON[["features"]][["properties"]])

str(df)
rm(hexMap_JOIN)
hexMap_JOIN02 <- merge(df, hexMap,
                     by.x = "Local Authority", by.y = "n",
                     all.x = TRUE)


