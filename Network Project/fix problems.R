# Function to extract vertex attribute from igraph object
# and use it to color the nodes in the plot
# Input: igraph object, vertex attribute name
# Output: plot of the graph with colored nodes
# TODO:
# 1. Figure out if the attribute is a factor or numeric
# 2. Add an argument to specify a color palette
# 3. Explore how to work with formulas. Ideally, we need the following
#    a. Read the formula
#    b. Capture the elements. For now, all shold be vertex attributes
#    c. Extract the vertex attributes from the graph
#    d. If it doesn't exist, throw an error using the stop() function.
# 4. Go over the netplot_edge_formulae function.
#------------------------------------------------------------

# Load required packages
library(igraph)
library(RColorBrewer)

color_nodes <- function(g, attribute, palette = "Set1") {
  
  # Check that attribute exists
  if (!(attribute %in% names(g))) {
    stop("Attribute does not exist in graph")
  }
  
  # Check attribute type
  attr_type <- typeof(g[[attribute]]) 
  
  # Handle factors
  if (attr_type == "factor") {
    
    # Extract factor levels
    levels <- levels(g[[attribute]]) 
    
    # Map levels to colors
    col_map <- palette[1:length(levels)]  
    
    # Color nodes
    V(g)$color <- col_map[g[[attribute]]]
  }  
  
  # Handle numerics 
  else if (attr_type == "numeric") {
    
    # Find min and max
    attr_min <- min(g[[attribute]])
    attr_max <- max(g[[attribute]])  
    
    # Create color scale
    col_map <- colorRampPalette(palette)(attr_min:attr_max)  
    
    # Color nodes based on attribute value
    V(g)$color <- col_map[g[[attribute]]]
  }
  
  # Handle logicals
  else if (attr_type == "logical") {
    
    # Map TRUE/FALSE to colors
    col_map <- c("blue", "red")  
    
    # Color nodes 
    V(g)$color <- col_map[g[[attribute]]]
  }
  
  # Handle other types (characters, dates)
  else {
    stop("Attribute type not supported")
  }  
  
  # Check that color palette exists
  if (!(palette %in% names(RColorBrewer::brewer.pal()))) {
    palette <- "Set1"
    message("Invalid palette name, using Set1")
  }
  
  # Use layout_in_circle() for igraph < 0.7.0
  if (packageVersion("igraph") < "0.7.0") {
    plot(g, vertex.color = V(g)$color, vertex.size = 5, layout = layout_in_circle())
  } else {
    plot(g, vertex.color = V(g)$color, vertex.size = 5, layout = layout_nicely())
  }
}

# Factor attribute
g1 <- graph_from_data_frame(d = data.frame(from = c(1, 2, 3), 
                                           to = c(2, 3, 1)), 
                            directed = FALSE)
V(g1)$group <- factor(c("A", "A", "B"))
color_nodes(g1, "group") 

# Numeric attribute
g2 <- graph_from_data_frame(d = data.frame(from = c(1, 2, 3), 
                                           to = c(2, 3, 1)), 
                            directed = FALSE)
V(g2)$value <- c(1, 3, 2)
color_nodes(g2, "value", "Blues")

# Logical attribute
g3 <- graph_from_data_frame(d = data.frame(from = c(1, 2, 3), 
                                           to = c(2, 3, 1)), 
                            directed = FALSE)
V(g3)$selected <- c(TRUE, FALSE, TRUE)
color_nodes(g3, "selected")

# Invalid palette name 
g4 <- graph_from_data_frame(d = data.frame(from = c(1, 2, 3), 
                                           to = c(2, 3, 1)), 
                            directed = FALSE) 
V(g4)$group <- factor(c("A", "A", "B"))
color_nodes(g4, "group", "InvalidPalette") 

# Attribute that does not exist
color_nodes(g1, "fake_attr")
