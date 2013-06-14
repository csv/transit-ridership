source('data.r')
library(grDevices)

ridership$newyork.prop <- ridership$newyork / max(ridership$newyork)
ridership$chicago.prop <- ridership$chicago / max(ridership$chicago)

#' Color palette
COL <- list(
  chicago = rgb(0.5, 0.0, 0.0, max = 1),
  newyork = rgb(0.0, 0.5, 0.5, max = 1),
  off.white = rgb(0.9, 0.9, 0.9, max = 1),
  off.black = rgb(0.1, 0.1, 0.1, max = 1)
)

#' Plot the stuff that remains constant across days.
plot.base <- function() {
  x.axis <- seq.Date(as.Date('2010-04-01'), max(ridership$date), by = 'month')
  plot(rep(0:1, nrow(ridership)/2) ~ ridership$date, type = 'n', axes = F,
       xlab = '', main = '', ylab = '')
  axis(1, at = x.axis, labels = strftime(x.axis, format = '%b %Y'),
    col = COL$off.white, col.ticks = COL$off.white)

  chicago.axis <-  seq(0, 1e6, 1e5)
  axis(2, at = chicago.axis / max(chicago.axis), labels = as.character(chicago.axis),
    col = COL$chicago, col.ticks = COL$chicago)
  mtext('Chicago', side = 2, col = COL$chicago)

  newyork.axis <- seq(0, 6e6, 5e5)
  axis(4, at = newyork.axis / max(newyork.axis), labels = newyork.axis,
    col = COL$newyork, col.ticks = COL$newyork)
  mtext('New York', side = 4, col = COL$newyork)
}

#' Plot a frame of video.
plot.date <- function(date) {
  ridership.sofar <- ridership[ridership$date <= date,]
  par(bg = COL$off.black,
      col = COL$off.white,
      col.axis = COL$off.white,
      col.main = COL$off.white,
      col.lab  = COL$off.white,
      col.sub  = COL$off.white
      )
  plot.base()

  # One line per day
  a_ply(ridership.sofar, 1, function(df){
    this.date <- df[1,'date']
    newyork <- df[1,'newyork.prop']
    chicago <- df[1,'chicago.prop']

    if (newyork > chicago) {
      line.color <- COL$newyork
    } else {
      line.color <- COL$chicago
    }
    lines(rep(this.date, 2), c(newyork, chicago), col = line.color)
  })

  # Print the date.
  mtext(strftime(date, format = '%A, %B %m, %Y'), side = 3)
}
