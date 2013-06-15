#!/bin/sh
bpm=140

sox -M chicago.wav newyork.wav beat.wav /tmp/transit.wav
ffmpeg -r $(perl -e "print $bpm/60;") -i frames/%04d.png -i /tmp/transit.wav -qscale 0 transit.webm

