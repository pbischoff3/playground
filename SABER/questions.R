library(tidyverse)
library(knitr)
library(kableExtra)

# Read the CSV data
data <- read_csv("SABER/data/questions.csv")

# Get unique block names
block_names <- unique(data$Block)

# Create an empty list to store the styled tables
styled_tables <- list()

# Define a vector of color hues
color_hues <- c("#FF7F50", "#6495ED", "#DC143C", "#32CD32", "#FFD700", "#9370DB", "#8A2BE2", "#FF1493", "#00CED1", "#06CED1")

# Check if the length of color_hues matches the number of unique block names
if (length(color_hues) < length(block_names)) {
  stop("Insufficient color values provided in color_hues vector.")
}

# Iterate over each block name
for (i in seq_along(block_names)) {
  # Subset the data for the current block name
  block_data <- data %>% filter(Block == block_names[i])
  
  # Create the table
  table <- kable(block_data, 
                 col.names = c("Block", "Question"), 
                 align = c("l", "l"), 
                 caption = paste("CSV Data Table -", block_names[i]))
  
  # Check if a valid color hue is available
  if (substr(color_hues[i], 1, 1) != "#" || nchar(color_hues[i]) != 7) {
    warning("Invalid color value provided for block:", block_names[i], ". Using default color.")
    color_hue <- "#000000" # Default color if an invalid color value is encountered
  } else {
    color_hue <- color_hues[i]
  }
  
  # Customize the table appearance with a unique color for each block
  styled_table <- table %>% 
    kable_styling(full_width = FALSE, 
                  font_size = 12, 
                  fixed_thead = TRUE, 
                  bootstrap_options = c("striped", "hover"),
                  latex_options = c("repeat_header")) %>% 
    add_header_above(c("", sprintf("Block: %s", block_names[i])), bold = TRUE, color = color_hue)
  
  # Append the styled table to the list
  styled_tables[[i]] <- styled_table
}

# Combine all the styled tables into a single output
combined_table <- kable_styling(kable(as.data.frame(matrix(unlist(styled_tables), ncol = 1, byrow = TRUE)), 
                                      format = "html", escape = FALSE, table.attr = 'class="table"'))

# Display the combined table
combined_table