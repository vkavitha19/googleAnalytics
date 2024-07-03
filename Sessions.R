library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
#install.packages("scales")
library("scales")
## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()
## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id = 154893193
# downloading Google API
ga_data = google_analytics(ga_id, date_range = c("2017-06-11", "2017-07-18"), metrics = c("ga:sessions"), dimensions = c("ga:userType"))
# using example file
# Load necessary libraries
library(ggplot2)
library(scales)

# Read the CSV file
ga_data <- read.csv("D:/SSU/NewVsRetruning.csv", sep=",", header=TRUE)

# Data cleaning and preparation
# Create a data frame with user types and sessions
ga_data.toPlot <- data.frame(userType = ga_data$User.Type, sessions = ga_data$Sessions)

# Remove commas from sessions and convert to numeric
ga_data.toPlot$sessions <- as.numeric(gsub(",", "", ga_data.toPlot$sessions))

# Calculate percentage
ga_data.toPlot$percentage <- ga_data.toPlot$sessions / sum(ga_data.toPlot$sessions)

# Check for and handle missing or non-numeric values
ga_data.toPlot <- na.omit(ga_data.toPlot)
ga_data.toPlot <- ga_data.toPlot[!is.na(ga_data.toPlot$sessions), ]

# Plot
ggplot(data = ga_data.toPlot, aes(x = factor(userType), y = sessions, fill = userType)) + 
  geom_bar(width = 0.6, stat = "identity") +  
  geom_text(aes(y = sessions / 2, label = percent(percentage)), size = 5) +
  labs(title = "Sessions by User Type", x = "User Type", y = "Number of Sessions") +
  theme_minimal()