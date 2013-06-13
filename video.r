source('data.r')
library(grDevices)

ridership$newyork.prop <- ridership$newyork / max(ridership$newyork)
ridership$chicago.prop <- ridership$chicago / max(ridership$chicago)

plot.base <- function() {
  x.axis <- seq.Date(as.Date('2010-04-01'), max(ridership$date), by = 'month')
  plot(rep(0:1, nrow(ridership)/2) ~ ridership$date, type = 'n', axes = F,
       xlab = 'Day', main = 'Transit ridership', ylab = '')
  axis(1, at = x.axis, labels = strftime(x.axis, format = '%b %Y'))

  chicago.axis <-  seq(0, 1e6, 1e5)
  axis(2, at = chicago.axis / max(chicago.axis), labels = chicago.axis)
  mtext('Chicago', side = 2)

  newyork.axis <- seq(0, 6e6, 5e5)
  axis(4, at = newyork.axis / max(newyork.axis), labels = newyork.axis)
  mtext('New York', side = 4)
}

plot.date <- function(date) {
  df <- ridership[ridership$date <= date,]
  par(bg = 'grey')
  plot.base()
  lines(newyork.prop ~ date, data = df, col = rgb(1,0,0,0.5, max = 1))
  lines(chicago.prop ~ date, data = df, col = rgb(0,1,1,0.5, max = 1) )
}
