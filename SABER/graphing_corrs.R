# Install ggplot2 package 
## install.packages("ggplot2")  

# Install corrplot package
## install.packages("corrplot")  

# Load libraries
library(ggplot2)
library(corrplot)

# Read in data 
data1 <- read.csv("./SABER/data/medical_interruptions.csv")

# Check structure of data1
str(data1) 

# Convert data1 to data frame
data <- as.data.frame(data1)  

# Calculate correlation matrix  
corr_matrix <- cor(data)  

# Correlation plot 
corrplot(corr_matrix, method="circle")  

# Scatterplot matrix 
pairs(data)

# Individual scatterplots
ggplot(data, aes(x = Sci_Ident_AVE, y = Sci_Engagement_Ave)) + 
  geom_point() + 
  geom_smooth(se = FALSE) +
  theme_bw()

ggplot(data, aes(x = Sci_SenseOfBelong_Ave, y = Sci_Career_Mot_AVE)) + 
  geom_point() + 
  geom_smooth(se = FALSE) +
  theme_bw() 

# Scatterplot of Sci_Ident_AVE vs Sci_Engagement_Ave
ggplot(data, aes(x = Sci_Ident_AVE, y = Sci_Engagement_Ave)) + 
  geom_point() + 
  geom_smooth(se = FALSE) +
  theme_bw()

# Scatterplot of Sci_SenseOfBelong_Ave vs Sci_Career_Mot_AVE
ggplot(data, aes(x = Sci_SenseOfBelong_Ave, y = Sci_Career_Mot_AVE)) + 
  geom_point() + 
  geom_smooth(se = FALSE) +
  theme_bw() 
