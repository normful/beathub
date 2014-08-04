#!/bin/bash
find . -type f -mindepth 2 -name "*.cue" -print0 | sed s/.cue//g | xargs -0 -I{} mp3splt -c "{}.cue" -T 12 -o "split/@N @A - @t" "{}.mp3"
