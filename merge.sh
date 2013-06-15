#!/bin/sh
bpm=140

ffmpeg -r $(perl -e "print $bpm/60;") -i frames/%04d.png -i transit.mp3 -sameq transit.webm

