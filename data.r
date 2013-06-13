library(plyr)
library(sqldf)

chicago <- read.csv('chicago.csv')[c('date','rides')]
chicago <- sqldf('SELECT date, sum(rides) AS \'n\' FROM chicago GROUP BY date;')
chicago$date <- strptime(chicago$date, format = '%m/%d/%Y')

newyork <- read.csv('newyork.csv')[c('date', 'entries')]
names(newyork)[2] <- 'n'
newyork$date <- as.Date(newyork$date)
