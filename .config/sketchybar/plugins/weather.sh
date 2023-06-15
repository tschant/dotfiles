#!/usr/bin/env sh

WEATHER=$(curl -s 'wttr.in/66061?format=%c%t&u')
sketchybar --set $NAME label="$WEATHER"
