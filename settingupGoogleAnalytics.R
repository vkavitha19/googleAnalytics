#install.packages("googleAuthR")
#install.packages("googleAnalyticsR")
library(googleAuthR)
library(googleAnalyticsR)
ga_auth()
account_list <- ga_account_list()
account_list$viewId
ga_id=90822334
temp_ga_data <- google_analytics(
  ga_id,
  date_range = c("2017-02-22", "2017-05-22"),
  metrics = c("sessions"),
  dimensions = c("date"),
  anti_sample = TRUE # Prevents sampling if the dataset is large
)
