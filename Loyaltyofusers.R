# Load necessary libraries
library(ggplot2)
library(scales)

# Load the data
ga_data = read.csv("D:/SSU/Day 1/FrequencyRegency.csv", sep=",", header=T)

# Make sure the axis show up correctly
CountOfSessions = rev(ga_data$Count.of.Sessions)
ga_data$Count.of.Sessions = factor(ga_data$Count.of.Sessions, levels = CountOfSessions)
ga_data$Users = as.numeric(gsub(",", "", ga_data$Users))

# Calculate percentage
ga_data$UsersPercentage = ga_data$Users / sum(ga_data$Users)
toPlot.PagesPerUser = ga_data

# Set the theme
theme_set(theme_bw())

# Example data for New vs Returning Visitors (since it's missing from your snippet)
# Create a sample data frame for New vs Returning Visitors
toPlot.NewvsReturningVisitors <- data.frame(
  userType = c("New Visitor", "Returning Visitor"),
  sessions = c(10000, 5000),  # Example numbers
  percentage = c(0.6667, 0.3333)  # Example percentages
)

# Plot for New vs Returning Visitors
ggplot(toPlot.NewvsReturningVisitors, aes(x=userType, y=sessions, fill=userType)) +
  geom_bar(width = 0.6, stat="identity") +
  geom_text(aes(y = sessions/2, label = scales::percent(percentage)), size=5) +
  labs(title="Visitor Plot", subtitle="New Vs Returning Visitors") +
  ylab("Number of Visitors") +
  scale_y_continuous(breaks=seq(0,15000,1000))

# Loyalty plot
ggplot(toPlot.PagesPerUser, aes(x=Count.of.Sessions, y=Users)) + 
  geom_bar(stat="identity", width=0.8, fill="tomato3") + 
  coord_flip() + 
  geom_text(aes(y = Users, label = scales::percent(UsersPercentage)), hjust = -0.1) + 
  scale_y_continuous(breaks = seq(0, 110000, 20000), limits = c(0, 110000), labels = scales::comma) + 
  ylab("Number of Sessions") + 
  xlab("Number of Users") + 
  labs(title="Loyalty plot", subtitle="Number of Sessions per User") + 
  theme(axis.text.x = element_text(angle=45, vjust=0.6))
