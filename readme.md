Transit ridership
======
This is a music video about the ridership of Chicago buses and New York subways
for the past few years.

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
