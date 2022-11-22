#!/usr/bin/env sh

sketchybar --add item     calendar right                    \
           --set calendar icon=cal                          \
                          icon.font="$FONT:Semibold:14.0"   \
													icon.padding_left=15              \
                          icon.padding_right=0              \
                          label.width=75                    \
                          label.align=right                 \
													label.font="$FONT:Regular:14.0"   \
                          background.padding_left=15        \
                          update_freq=30                    \
                          script="$PLUGIN_DIR/calendar.sh"
