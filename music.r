library(ddr)
source('data.r')

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

# Ridership counts to notes
chicago <- arpeggidata(ridership$chicago, blip, bpm = bpm, count = count)
writeWave(chicago, 'chicago.wav')
newyork <- arpeggidata(ridership$newyork, piano, bpm = bpm, count = count)
writeWave(newyork, 'newyork.wav')

# This probably won't sound that good.
pca <- as.data.frame(princomp(ridership[c('chicago','newyork')], cor = T)$scores)
comp.1 <- arpeggidata(pca$Comp.1, blip, bpm = bpm, count = count, scale="Emajor")
writeWave(comp.1, 'comp1.wav')
comp.2 <- arpeggidata(pca$Comp.2, piano, bpm = bpm, count = count, scale="Cmajor")
writeWave(comp.2, 'comp2.wav')
