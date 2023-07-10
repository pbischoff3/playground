# Load required packages
library(ggplot2)
library(dplyr)
library(gridExtra)

# Create a data frame from the provided .csv data
data <- read.csv("SABER/data/pre_post.csv")

# Rename the columns
colnames(data) <- c("interruptions", "Pair", "Mean", "Std.Deviation", "Std.Error.Mean",
                    "Lower", "Upper", "t", "df", "Sig")

# Get unique pair names
pair_names <- unique(data$Pair)

# List to store individual graphs
graphs <- list()

# New names for the pairs
new_pair_names <- c("Science Identity", "Science Career Motivation", "Science Interest",
                    "Self-Determination", "Self-Efficacy", "Community in Science")

# Generate graphs for each pair
for (i in seq_along(pair_names)) {
  # Filter data for the specific pair
  pair_data <- data %>%
    filter(Pair == pair_names[i])
  
  # Filter significant data points (Sig <= 0.05)
  sig_data <- pair_data %>%
    filter(Sig <= 0.05)
  
  # Create plot for the specific pair
  plot <- ggplot(pair_data, aes(x = factor(interruptions), y = Mean, fill = factor(interruptions))) +
    geom_bar(stat = "identity", position = "dodge") +
    geom_errorbar(aes(ymin = Mean - Std.Error.Mean, ymax = Mean + Std.Error.Mean),
                  position = position_dodge(width = 0.9), width = 0.25) +
    labs(x = "Number of Medical Interruptions", y = "Mean") +
    ggtitle(new_pair_names[i]) +
    scale_fill_manual(values = c("#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF", "#00FFFF")) +
    theme_minimal() +
    theme(legend.position = "none") +
    theme(panel.border = element_rect(color = "black", fill = NA))
  
  # Add significance points to the plot
  if (nrow(sig_data) > 0) {
    plot <- plot +
      geom_point(data = sig_data, aes(y = Mean + Std.Error.Mean + 0.2), shape = 16, size = 3, color = "black")
  }
  
  # Store the plot in the list
  graphs[[i]] <- plot
}

# Combine graphs into a grid
combined_plot <- grid.arrange(grobs = graphs, nrow = 2, ncol = 3, padding = unit(10, "cm"))

# Display the combined plot
print(combined_plot)


# Specify the file path and name
file_path <- "SABER/plots/"
file_name <- "pre_post_mean.PNG"

# Set the width and height in inches
width <- 11.5
height <- 7.9

# Save the combined plot as a PNG file
ggsave(file = paste0(file_path, file_name), plot = combined_plot, width = width, height = height)

