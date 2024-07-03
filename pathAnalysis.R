library(ggplot2)
library(scales)
library(dplyr)
library(networkD3)

# Load the sample data from CSV
ga_data <- read.csv("D:/SSU/Day 1/sample_google_analytics_data.csv", sep=",", header=T)

# Clean and prepare the data
ga_data$pageviews <- as.numeric(gsub(",", "", ga_data$pageviews))
ga_data$sessions <- as.numeric(gsub(",", "", ga_data$sessions))
ga_data$users <- as.numeric(gsub(",", "", ga_data$users))

# Summarize data
path_summary <- ga_data %>%
  group_by(pagePath, previousPagePath) %>%
  summarize(
    total_pageviews = sum(pageviews),
    total_sessions = sum(sessions),
    total_users = sum(users),
    .groups = 'drop'  # Override the default grouping behavior
  )


# Plot total sessions for each pagePath
ggplot(path_summary, aes(x = reorder(pagePath, total_sessions), y = total_sessions, fill = previousPagePath)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Total Sessions for Each Page Path", x = "Page Path", y = "Total Sessions") +
  scale_fill_discrete(name = "Previous Page Path")

# Prepare data for Sankey plot
nodes <- data.frame(name = unique(c(path_summary$pagePath, path_summary$previousPagePath)))
links <- path_summary %>%
  mutate(
    source = match(previousPagePath, nodes$name) - 1,
    target = match(pagePath, nodes$name) - 1
  ) %>%
  select(source, target, total_sessions)

# Create Sankey plot
sankeyNetwork(
  Links = links, 
  Nodes = nodes,
  Source = "source", 
  Target = "target", 
  Value = "total_sessions",
  NodeID = "name", 
  units = "Sessions",
  fontSize = 12, 
  nodeWidth = 30
)