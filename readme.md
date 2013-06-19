Transit ridership
======
This is a music video about the ridership of Chicago buses and New York subways
for the past few years.

Each musical beat is a day, as is each vertical line. One musical instrument
represents the daily ridership of Chicago buses, and the other represens the daily
ridership of New York subways. (Both are measured at fare collection points.)

The vertical line on the graph also represents the daily ridership. It is colored
according to the city whose ridership was proportionately higher for that day.
The top of the line is the rate for the city with proportionately higher ridership,
and the bottom of the line is for the one with proportionately lower ridership.

Daily ridership is also represented by the white/grey ticks at the left and right
of the video. The brightest tick is for the present day, and the duller ticks are
for progressively earlier days going back seven days.

## How to
Generate the music. (This unnecessarily requires a graphical display.)

    Rscript music.r

Generate the video.

    Rscript video.r

Merge them.

    sh merge.sh

The resulting video is called `transit.webm`.

## File organization
Data import is in `data.r`.
Music stuff goes in `music.r`, and video stuff goes in `video.r`.
The resulting files are merged into a webm video in `merge.sh`.

## Legend


## Analysis
