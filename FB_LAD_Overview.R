library(readxl)

# Load required package
library(jsonlite)

setwd("/Users/paulgoodship/Documents/Data Projects/UK Proximity Analysis/Foodbanks/Data")

url <- "https://www.trusselltrust.org/wp-content/uploads/sites/2/2023/04/Trussell-Trust-End-of-Year-Statistics-2022-23.xlsx"
filename <- "Trussell-Trust-End-of-Year-Statistics-2022-23.xlsx"

# Download file to local directory
download.file(url, destfile = filename, mode = "wb")

# Read in Excel file
df <- read_excel(filename, sheet = 2)
str(df)

# Loop over columns 3 to 6
for (i in 3:6) {
  df[1, i] <- paste(colnames(df)[3], df[1, i], sep = " ")
}

# Loop over columns 7 to 10
for (i in 7:10) {
  df[1, i] <- paste(colnames(df)[7], df[1, i], sep = " ")
}

# Loop over columns 11 to 14
for (i in 11:14) {
  df[1, i] <- paste(colnames(df)[11], df[1, i], sep = " ")
}

# Loop over columns 15 to 18
for (i in 15:18) {
  df[1, i] <- paste(colnames(df)[15], df[1, i], sep = " ")
}

# Loop over columns 19 to 22
for (i in 19:22) {
  df[1, i] <- paste(colnames(df)[19], df[1, i], sep = " ")
}

# Loop over columns 23 to 26
for (i in 23:26) {
  df[1, i] <- paste(colnames(df)[23], df[1, i], sep = " ")
}

# Assign the first row as the new column names
colnames(df) <- df[1, ]

# Remove the first row from the data frame
df <- df[-1, ]

str(df)

#write the final csv
write.csv(df,"Foodbank_LAD.csv")


#get the LAD name data
url2 <- "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Authority_Districts_December_2022_UK_BGC_V2/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson"

# Download data from URL
data2 <- jsonlite::fromJSON(url2)

# Convert data to data frame
df2 <- as.data.frame(data2$features$properties)

#local authority name data to foodbank data
DF3 <- merge(df,df2,
             by.x = "Local Authority", by.y = "LAD22NM",
             all.x = TRUE)


#get population data 
# https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland

pop_URL <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland/mid2021/ukpopestimatesmid2021on2021geographyfinal.xls"

# Download file to local directory
filename2 <- "ukpopestimatesmid2021on2021geographyfinal.xls"
download.file(pop_URL, destfile = filename2, mode = "wb")

PopEst_01_11_21 <- read_excel(filename2, sheet = "MYE4", skip = 7)
PopDen_01_11_21 <- read_excel(filename2, sheet = "MYE 5", skip = 7)
PopAge_01_11_21 <- read_excel(filename2, sheet = "MYE 6", skip = 7)


DF4 <- merge(DF3,PopEst_01_11_21,
             by.x = "LAD22CD", by.y = "Code",
             all.x = TRUE)

DF4 <- merge(DF4,PopDen_01_11_21,
             by.x = "LAD22CD", by.y = "Code",
             all.x = TRUE)

DF4 <- merge(DF4,PopAge_01_11_21,
             by.x = "LAD22CD", by.y = "Code",
             all.x = TRUE)
str(df2)

#add some basic calc
#annual change
#change since first year
#per person

