#!/usr/bin/env sh
source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

WIDTH="dynamic"
BACKGROUND="$BACKGROUND_1"
if [ "$SELECTED" = "true" ]; then
	BACKGROUND="$CYAN"
fi

sketchybar --set $NAME icon.highlight=$SELECTED label.width=$WIDTH background.color=$BACKGROUND
