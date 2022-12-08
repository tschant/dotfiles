#!/usr/bin/env sh

WEATHER=$(curl -s 'wttr.in/66061?format=%c%t')
sketchybar --set $NAME label="$WEATHER"
