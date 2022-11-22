#!/usr/bin/env sh

WIDTH="35"
if [ "$SELECTED" = "true" ]; then
	WIDTH="dynamic"
fi

sketchybar --set $NAME icon.highlight=$SELECTED label.width=$WIDTH
