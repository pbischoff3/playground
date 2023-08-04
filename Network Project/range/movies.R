# first chunk ####
# install from drat
# install.packages("drat")
# drat::addRepo("schochastics")
# install.packages("networkdata")

# load packages
library(igraph)
library(networkdata)

# explore what datasets we have 
data(package = "networkdata")

# second chunk ####
xmen <- movie_766
dumb_and_dumber <- movie_226
indiana_jones <- movie_367
mission_impossible <- movie_483
star_wars <- movie_656


# xmen plot####
library(devtools)
# install_github("USCCANA/netplot")
library(netplot)

# Set the file path for the PNG output
png_file <- "Network Project/range/plots/xmen.PNG"

# Open the PNG device
png(png_file, width = 2000, height = 1500)  

set.seed(33)
nplot(xmen,
      vertex.nsides = 3,
      edge.color = ~ego(alpha = .75, col = "gray") + alter(alpha = .75, col = "gray"),
      vertex.color ="dodgerblue4",
      vertex.label.show = .5,
      vertex.size = 6,
      edge.width = 3,
      vertex.label.fontsize = 30,
      vertex.label.color = "black",
      vertex.label.fontfamily = "Courier")

dev.off()


# dumb_and_dumber ####
library(devtools)
# install_github("USCCANA/netplot")
library(netplot)

# Set the file path for the PNG output
png_file <- "Network Project/range/plots/d_a_d.PNG"

# Open the PNG device
png(png_file, width = 2000, height = 1500)  

set.seed(33)
nplot(dumb_and_dumber,
      vertex.nsides = 8,
      edge.color = ~ego(alpha = .75, col = "darkslategray3") + alter(alpha = .75, col = "gray"),
      vertex.color ="deeppink",
      vertex.frame.color = "darkorchid4",
      vertex.size = 6,
      edge.width = 3,
      vertex.label.color = "black",
      vertex.label.fontfamily = "Courier",
      vertex.label.range = c(1,30))

dev.off()


# indiana_jones ####
library(devtools)
# install_github("USCCANA/netplot")
library(netplot)

# Set the file path for the PNG output
png_file <- "Network Project/range/plots/ij.PNG"

# Open the PNG device
png(png_file, width = 2000, height = 1500)  

set.seed(33)
nplot(indiana_jones,
      bg.col = "linen",
      vertex.nsides = 5,
      vertex.label.show = 1,
      edge.color = ~ego(alpha = .75, col = "ivory4") + alter,
      vertex.color ="darkred",
      vertex.frame.color = "slategray",
      edge.width = 3,
      edge.line.lty = 2,
      edge.line.breaks = 15,
      edge.curvature = 1.57,
      vertex.label.color = "black",
      vertex.label.fontfamily = "Courier",
      vertex.label.range = c(15,50))

dev.off()


# mission impossible ####
library(devtools)
# install_github("USCCANA/netplot")
library(netplot)

# Set the file path for the PNG output
png_file <- "Network Project/range/plots/mi.PNG"

# Open the PNG device
png(png_file, width = 2000, height = 1500)  

set.seed(33)
nplot(mission_impossible,
      bg.col = "lightslategray",
      edge.color = "lightgoldenrod",
      edge.width = 100,
      skip.vertex = TRUE)

dev.off()

# star wars ####
library(devtools)
# install_github("USCCANA/netplot")
library(netplot)

# Set the file path for the PNG output
png_file <- "Network Project/range/plots/sw.PNG"

# Open the PNG device
png(png_file, width = 2000, height = 1500)  

set.seed(33)
# Add new character groups
rebels <- c("BEN", "BIGGS", "DODONNA", "GOLD LEADER", "HAN", "LEIA", "LUKE",
            "RED LEADER", "RED NINE", "RED TEN", "THREEPIO", "WEDGE", "WILLARD", "WINGMAN")

empire <- c("CHIEF", "COMMANDER", "DEATH STAR INTERCOM VOICE", "FIRST OFFICER", "FIRST TROOPER", 
            "GANTRY OFFICER", "IMPERIAL OFFICER", "MOTTI", "OFFICER", "SECOND OFFICER", 
            "SECOND TROOPER", "TAGGE", "TARKIN", "TROOPER", "VADER")

outlaws <- c("GREEDO", "JABBA")

supporting <- c("AUNT BERU", "BARTENDER", "BERU", "CAMIE", "CREATURE", "FIXER", 
                "HUMAN", "INTERCOM VOICE", "MAN", "OWEN", "TECHNICIAN")

# Set alignment for each group
library(netplot)
alignment <- star_wars$alignment
alignment[match(rebels, V(star_wars)$name)] <- "rebel" 
alignment[match(empire, V(star_wars)$name)] <- "empire"
alignment[match(outlaws, V(star_wars)$name)] <- "outlaw"
alignment[match(supporting, V(star_wars)$name)] <- "supporting"
V(star_wars)$alignment <- alignment


# Plot with alignment coloring 
source("../../others/netplot-sunbelt2023/misc/color_nodes_function.R")

plot.new()

set.seed(33)
nplot(star_wars,  
      vertex.color = color_nodes(star_wars, "alignment",  
                                 c("firebrick2", "goldenrod1", "dodgerblue3", "darkseagreen")),
      vertex.label.color = "black",
      vertex.label.fontfamily = "Courier",
      vertex.label.range = c(15,50))

# Add legend
legend("bottomright",  
       legend = c("Rebels", "Empire", "Outlaws", "Supporting"),
       fill = c("dodgerblue3", "firebrick2", "goldenrod1", "darkseagreen"))


dev.off()
