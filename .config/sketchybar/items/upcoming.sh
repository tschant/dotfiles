#!/usr/bin/env sh

# TODO: Need to update `sketchybar_bottom` to be dynamic
POPUP_CLICK_SCRIPT="sketchybar_bottom --set \$NAME popup.drawing=toggle"

sketchybar_bottom -m --add item     upcoming left                                  \
              --set upcoming update_freq=1                                   \
                             updates=on                                       \
                             label="No Upcoming Events" \
                             label.font="$FONT:Regular:14.0"\
                             label.color=$WHITE                               \
                             script="/usr/bin/python3 $PLUGIN_DIR/upcoming.py"         \
                             click_script="$POPUP_CLICK_SCRIPT"
