# Load the jsonlite package
library(jsonlite)
library(tidyr)
library(dplyr)
library(stringr)

getwd()
setwd()
# Read the JSON file from the URL
json_data <- fromJSON("https://raw.githubusercontent.com/givefood/data/main/needs.json")

# Convert the data to a data frame
df <- as.data.frame(json_data)

# Print the first few rows of the data frame
head(df)
#update

df2 <- separate_rows(df, needs, sep = "\n")
#df2$join <- gsub("\\([^)]+\\)|\\[[^]]+\\]", "", needs$df2.needs)
#colnames(df2)[7] <- "join"

needs <- data.frame(df2$needs)
needs

# Remove duplicated rows based on all columns
#needs <- unique(needs)

# Remove anything in brackets using gsub() and regular expressions
needs_a <- data.frame(gsub("\\([^)]+\\)|\\[[^]]+\\]", "", needs$df2.needs))

colnames(needs_a)[1] <- "needs"

# Remove white spaces at the end using trimws()
needs_a <- as.data.frame(trimws(needs_a$needs, "right"))
colnames(needs_a)[1] <- "needs"
needs_a <- as.data.frame(trimws(needs_a$needs, "left"))
colnames(needs_a)[1] <- "needs"
#needs_a$reference <- row_number(needs_a)
needs_a <- as.data.frame(unique(needs_a$needs))

needs_a$reference <- row_number(needs_a)
colnames(needs_a)[1] <- "needs"

setwd("/Users/paulgoodship/Documents/Data Projects/Foodbank/Data")
write.csv(needs, "need.csv")
write.csv(needs_a, "need_a.csv", row.names = FALSE)


#take list into a ai chatbot to categories 

# chatGPT query :
# Can you please organise the foodbank items in the list below 
# into one for the following categories ONLY, keeping the reference number and 
# using a table – “Canned Vegetables and Fruits”, “Canned Proteins”, 
# “Pasta, Rice, and Grains”, “Canned Meals and Soups”, “Cooking Sauces and Condiments”, 
# “Bread and Bakery Items”, “Dairy and Milk Alternatives”, “Personal Care Items”, 
# “Baby and Infant Supplies”, “Treats and Snacks” - 

# library(readxl)
# 
# setwd("/Users/paulgoodship/Documents/Data Projects/Foodbank/Data")
# excel_file <- "need_ChatGPT_categories.xlsx"

# # Get the names of all sheets in the Excel file
# sheet_names <- excel_sheets(excel_file)
# sheet_names <- sheet_names[3:8]
# 
# 
# # Initialize an empty list to store dataframes
# dataframes_list <- list()
# 
# # Loop through each sheet and read it into a dataframe
# for (sheet_name in sheet_names) {
#   df <- read_excel(excel_file, sheet = sheet_name)
#   dataframes_list[[sheet_name]] <- df
# }

# # Assuming you have already loaded the `tidyr` library
# library(tidyr)
# 
# # Loop through each data frame in the list
# for (sheet_name in sheet_names) {
#   df <- dataframes_list[[sheet_name]]
#   
#   # Assuming the column where the `<br>` occurs is named "Items"
#   column_name <- "Items"
#   
#   # Split the values based on the <br> tag
#   df_split <- df %>% 
#     mutate(across({{column_name}}, ~strsplit(., "<br>"))) %>%
#     unnest(cols = {{column_name}})
#   
#   dataframes_list[[sheet_name]] <- df_split
# }


lookup <- read_excel("need_ChatGPT_categories.xlsx", sheet = "lookup")

# Remove anything in brackets using gsub() and regular expressions
df_join <- df2
df_join$join <- gsub("\\([^)]+\\)|\\[[^]]+\\]", "", needs$df2.needs)

#colnames(df_join)[7] <- "needs"

# Remove white spaces at the end using trimws()
df_join$join <- trimws(df_join$join, "right")
#colnames(df_join)[7] <- "join"
df_join$join <- trimws(df_join$join, "left")
#colnames(df_join)[7] <- "needs"




# Combine all data frames in dataframes_list into one dataframe
#combined_df <- bind_rows(dataframes_list)




# Remove leading white spaces from the "Items" column in the combined dataframe
#combined_df$Items <- str_trim(combined_df$Items, side = "left")

colnames(needs_a)[1] <- "join"

str(lookup)

df_join_merge <- merge(df_join, needs_a,
                  by.x = "join", by.y = "needs",
                  all.x = TRUE
                  )

df_FINAL <- merge(df_join_merge,lookup,
                  by.x = "reference", by.y ="Reference Number",
                  all.x = TRUE)


setwd("/Users/paulgoodship/Documents/Data Projects/Foodbank/Data")
write.csv(df_FINAL, "FINAL_need.csv")

