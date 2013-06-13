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
    ridership[1:280,]
  })()
}

ddr_init(player = '#!/usr/bin/env mplayer')
bpm <- 140
count <- 'seven_'

beat <- (function(){
  wavs <- list(roland$HHO, roland$SD1, roland$BD1)

  # Starts on Saturday; stress on index 3, 5 and 7, with 3 as the downbeat
  hihat <- c(1,1,    0,1,0,1,0)
  kick  <- c(0,0,    1,0,1,0,1)
  snare <- c(0,0,    0,0,0,0,1)
  seqs <- list(hihat, snare, kick)
  
  measure <- sequence(wavs, seqs, bpm = bpm, count = count)
  loop(measure, nrow(ridership)/7)
})()
writeWave(beat, 'beat.wav')

chicago <- arpeggidata(ridership$chicago, blip, bpm = bpm, count = count)
writeWave(chicago, 'chicago.wav')

newyork <- arpeggidata(ridership$newyork, sinewave, bpm = bpm, count = count)
writeWave(newyork, 'newyork.wav')
