library(sqldf)
library(plyr)

if (!('ridership' %in% ls())) {
  ridership <- (function(){
    chicago <- read.csv('chicago.csv')[c('date','rides')]
    chicago <- sqldf('SELECT date, sum(rides) AS \'chicago\' FROM chicago GROUP BY date;')
    chicago$date <- as.Date(strptime(chicago$date, format = '%m/%d/%Y'))
    
    newyork <- read.csv('newyork.csv')[c('date', 'entries')]
    names(newyork)[2] <- 'newyork'
    newyork$date <- as.Date(newyork$date)
    
    ridership <- join(chicago, newyork)
    ridership <- na.omit(ridership[order(ridership$date),])
    ridership
  })()
}
