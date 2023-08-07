#install spatial packages if needed
install.packages("geojsonio")
install.packages("sf")

library(geojsonio)
library(sf)
library(plyr)

url <- "https://raw.githubusercontent.com/givefood/data/main/locations.geojson"
geojson <- geojson_read(url, what = "sp")

df <- as.data.frame(geojson)


url2 <- "https://raw.githubusercontent.com/givefood/data/main/foodbanks.geojson"
geojson2 <- geojson_read(url2, what = "sp")

df2 <- as.data.frame(geojson2)

combined <- rbind.fill(df,df2)
