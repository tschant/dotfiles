#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh" # Loads all defined icons
sketchybar --set $NAME icon="$CALENDAR $(date '+%a %d. %b')" label="$(date '+%I:%M %p')"
