#!/usr/bin/env sh

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar -m --add item     upcoming center                                  \
  	          --set upcoming update_freq=20                                   \
  	                         updates=on                                       \
												     label="No Upcoming Events" \
												     label.font="$FONT:Regular:14.0"\
  											     label.color=$WHITE                               \
  	                         script="/usr/bin/python3 $PLUGIN_DIR/upcoming.py"         \
  	                         click_script="$POPUP_CLICK_SCRIPT"
