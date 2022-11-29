#!/usr/bin/env sh

WEATHER=$(curl -s 'wttr.in/?format=%c%t')
sketchybar --set $NAME label="$WEATHER"
