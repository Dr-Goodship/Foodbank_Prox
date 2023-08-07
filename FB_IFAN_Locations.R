library(sf)
library(xml2)

kml_file <- "/Users/paulgoodship/Documents/Data Projects/UK Proximity Analysis/Foodbanks/IFAN Members March 2023.kml"
kml_data <- st_read(kml_file, quiet = TRUE)

# Assuming you have already read the KML file and converted it to an sf object named kml_data

# Access the geometry column of the sf object
geometry <- kml_data$geometry

# Extract the longitude and latitude values
longitude <- st_coordinates(geometry)[, "X"]
latitude <- st_coordinates(geometry)[, "Y"]


# Assuming you have already read the KML file and converted it to an sf object named kml_data

# Extract the individual geometries from the collection
individual_geometries <- st_geometry(kml_data)

# Extract the longitude and latitude values for each geometry
longitude <- sapply(individual_geometries, function(geometry) st_coordinates(geometry)[, "X"])
latitude <- sapply(individual_geometries, function(geometry) st_coordinates(geometry)[, "Y"])




# Assuming you have already read the KML file and converted it to an sf object named kml_data

# Convert sfc_GEOMETRYCOLLECTION to individual geometries
individual_geometries <- st_cast(kml_data, "POINT")

# Extract the longitude and latitude values for each geometry
longitude <- st_coordinates(individual_geometries)[, "X"]
latitude <- st_coordinates(individual_geometries)[, "Y"]



# Assuming you have already read the KML file and converted it to an sf object named kml_data

# Extract the individual geometries from the collection
individual_geometries <- st_geometry(kml_data)

# Create empty vectors for longitude and latitude
longitude <- c()
latitude <- c()

# Iterate over each geometry type and extract coordinates
for (i in 1:length(individual_geometries)) {
  if (st_is(individual_geometries[[i]], "POINT")) {
    coordinates <- st_coordinates(individual_geometries[[i]])
    longitude <- c(longitude, coordinates[, "X"])
    latitude <- c(latitude, coordinates[, "Y"])
  }
}

individual_geometries[[2]]
