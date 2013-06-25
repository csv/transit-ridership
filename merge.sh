#!/bin/sh
set -e

test -e /tmp/transit.wav || sox -M chicago.wav newyork.wav beat.wav /tmp/transit.wav

bpm=140
# rate=$(perl -e "print 2 * $bpm / 60;")
rate=$(perl -e "print ($(wc -l newyork.csv) - 1) / (4 * 60 + 13.71);")

ffmpeg -r $rate -i frames/%04d.png -i /tmp/transit.wav -q:v 0 transit.webm

