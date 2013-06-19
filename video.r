source('data.r')
library(grDevices)

ridership$newyork.prop <- ridership$newyork / max(ridership$newyork)
ridership$chicago.prop <- ridership$chicago / max(ridership$chicago)

#' Color palette
COL <- list(
  chicago = rgb(1.0, 1.0, 0.0, max = 1),
  newyork = rgb(0.0, 1.0, 1.0, max = 1),
  off.white = rgb(0.9, 0.9, 0.9, max = 1),
  off.black = rgb(0.1, 0.1, 0.1, max = 1),
  magenta = rgb(0.3, 0.0, 0.3, max = 1)
)

START.DATE <- as.Date(strftime(min(ridership$date), format = '%Y-%m-01'))
END.DATE   <- as.Date(paste(
  strftime(max(ridership$date), format = '%Y'),
  1 + as.numeric(strftime(max(ridership$date), format = '%m')),
  '01',
  sep = '-'))

#' Plot the stuff that remains constant across days.
plot.base <- function() {
  par(
    las = 0,
    mar = c(2, 6, 2, 6),
    oma = rep(0, 4),
    lwd = 5,
    lend = 2
  )
  x.axis <- seq.Date(START.DATE, END.DATE, by = 'month')
  plot(rep(0:1, nrow(ridership)/2) ~ ridership$date, type = 'n', axes = F,
       xlab = '', main = '', ylab = '')
  axis(1, at = x.axis, labels = strftime(x.axis, format = '%b %Y'),
    col = COL$off.white, col.ticks = COL$off.white)

  par(las = 2)
  chicago.axis <-  seq(0, 1e6, 2e5)
  text(START.DATE, chicago.axis / max(chicago.axis), labels = c('0', paste(c(2, 4, 6, 8), '00k', sep = ''), '1 million'), pos = 2, col = COL$chicago, font = 1)
  text(START.DATE, 1.05, 'Chicago', col = COL$chicago, pos = 2)

  newyork.axis <- seq(0, 6e6, 1e6)
  text(END.DATE, newyork.axis / max(newyork.axis), labels = c('0', paste(1:6, 'million')), pos = 4, col = COL$newyork, font = 1)
  text(END.DATE, 1.05, 'New York', col = COL$newyork, pos = 4)

  par(las = 0)
}

is.weekend <- function(date){
  day <- strftime(date, format = '%A')
  day == 'Friday' | day == 'Saturday' | day == 'Sunday'
}

#' Plot a frame of video.
plot.date <- function(date) {
  ridership.sofar <- ridership[ridership$date <= date,]

  day <- strftime(date, format = '%A')
  if(day == 'Saturday' | day == 'Sunday'){
    par(
      bg = COL$magenta
    )
  } else {
    par(
      bg = COL$off.black
    )
  }
  par(
    col = COL$off.white,
    col.axis = COL$off.white,
    col.main = COL$off.white,
    col.lab  = COL$off.white,
    col.sub  = COL$off.white,
    font = 2,
    xpd = T
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

  # Gauges on the sides
  last.week <- ridership.sofar[(ridership.sofar$date + 7) > date,]
  last.week$alpha <- ((nrow(last.week):1) ^ 2) / nrow(last.week)

  last.week$col <- rgb(nrow(last.week), nrow(last.week), nrow(last.week), last.week$alpha, max = nrow(last.week))
  a_ply(last.week, 1, function(df) {
    lines(START.DATE + c(5, 10), rep(df[1,'chicago.prop'], 2), col = df[1,'col'])
    lines(END.DATE   - c(5, 10), rep(df[1,'newyork.prop'], 2), col = df[1,'col'])
  })
}

ridership$i <- sprintf('%04d', 1:nrow(ridership))
a_ply(ridership, 1, function(df) {
  date <- df[1,'date']
  i <- df[1,'i']
  cat('Plotting frame',i,'\n')
  png(paste('frames/',i,'.png',sep=''), width = 3000, height = 1000, res = 200)
  plot.date(date)
  dev.off()
})
