library(plyr)
library(sqldf)
library(ddr)

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

ddr_init(player = '#!/usr/bin/env mplayer')
bpm <- 140
count <- 1/7

beat <- (function(){
  wavs <- list(roland$HHO, roland$SD1, roland$BD1)

  #          Weekend,     week
  hihat <- c(0,0,    1,0,1,0,1)
  kick  <- c(1,1,    0,1,0,1,0)
  snare <- c(0,0,    0,1,0,1,0)
  seqs <- list(hihat, snare, kick)
  
  measure <- sequence(wavs, seqs, bpm = bpm, count = count)
  loop(measure, nrow(ridership)/7)
})()


aoeu

chicago <- arpeggidata(ridership$chicago, piano)
writeWave(chicago, 'chicago.wav', bpm = bpm, count = count)

newyork <- arpeggidata(ridership$newyork, piano)
writeWave(newyork, 'newyork.wav', bpm = bpm, count = count)
