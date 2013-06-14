source('data.r')
library(grDevices)

ridership$newyork.prop <- ridership$newyork / max(ridership$newyork)
ridership$chicago.prop <- ridership$chicago / max(ridership$chicago)

#' Plot the stuff that remains constant across days.
plot.base <- function() {
  x.axis <- seq.Date(as.Date('2010-04-01'), max(ridership$date), by = 'month')
  plot(rep(0:1, nrow(ridership)/2) ~ ridership$date, type = 'n', axes = F,
       xlab = 'Day', main = '', ylab = '')
  axis(1, at = x.axis, labels = strftime(x.axis, format = '%b %Y'))

  chicago.axis <-  seq(0, 1e6, 1e5)
  axis(2, at = chicago.axis / max(chicago.axis), labels = chicago.axis)
  mtext('Chicago', side = 2)

  newyork.axis <- seq(0, 6e6, 5e5)
  axis(4, at = newyork.axis / max(newyork.axis), labels = newyork.axis)
  mtext('New York', side = 4)
}

COL <- list(
  chicago = rgb(1,0,0,0.5, max = 1),
  newyork = rgb(0,1,1,0.5, max = 1)
)

#' Plot a frame of video.
plot.date <- function(date) {
  ridership.sofar <- ridership[ridership$date <= date,]
  par(bg = 'grey')
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
