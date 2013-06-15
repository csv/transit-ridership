#!/bin/sh
set -e
bpm=140

test -e /tmp/transit.wav || sox -M chicago.wav newyork.wav beat.wav /tmp/transit.wav
ffmpeg -r $(perl -e "print 2 * $bpm / 60;") -i frames/%04d.png -i /tmp/transit.wav -qscale 0 transit.webm

