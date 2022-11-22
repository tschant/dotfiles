#!/usr/bin/env sh
# THESE ARE TIED WITH SYSTEM KEYBINDINGS
SPACE_KEY_STROKE=(122 120 99 118 96) # F1 F2 F3 F4 F5
KEY_STROKE="${SPACE_KEY_STROKE[$SID - 1]}"
osascript -e "tell application \"System Events\"" -e "key code $KEY_STROKE using (option down)"	-e "end tell"
sketchybar --trigger windows_on_spaces

