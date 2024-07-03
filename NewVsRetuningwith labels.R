library(ggplot2)
library(scales)

# Read the CSV file with correct parameters
ga_data <- read.csv("D:/SSU/NewVsRetruning.csv", sep=",", header=TRUE, stringsAsFactors = FALSE)

# Print the first few rows to verify the data
print(head(ga_data))

# Data cleaning and preparation
# Create a data frame with user types and sessions
ga_data.toPlot <- data.frame(userType = c("New Visitor", "Returning Visitor"), 
                             sessions = c(ga_data$Sessions[1], ga_data$Sessions[2]))

# Remove commas from sessions and convert to numeric
ga_data.toPlot$sessions <- as.numeric(gsub(",", "", ga_data.toPlot$sessions))

# Print to verify conversion
print(ga_data.toPlot)

# Calculate percentage
ga_data.toPlot$percentage <- ga_data.toPlot$sessions / sum(ga_data.toPlot$sessions)

# Check for and handle missing or non-numeric values
ga_data.toPlot <- na.omit(ga_data.toPlot)
ga_data.toPlot <- ga_data.toPlot[!is.na(ga_data.toPlot$sessions), ]

# Print the final cleaned data
print(ga_data.toPlot)

# Plot
ggplot(data = ga_data.toPlot, aes(x = factor(userType, levels = c("New Visitor", "Returning Visitor")), y = sessions, fill = userType)) + 
  geom_bar(width = 0.6, stat = "identity") +  
  geom_text(aes(y = sessions / 2, label = percent(percentage)), size = 5) +
  labs(title = "Sessions by User Type", x = "User Type", y = "Number of Sessions") +
  scale_fill_manual(values = c("New Visitor" = "blue", "Returning Visitor" = "green")) +
  theme_minimal()