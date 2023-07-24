#!/usr/bin/env sh

sketchybar --add item weather right                     \
           --set weather icon.drawing=off               \
											label.align=right                 \
											label.font="$FONT:Regular:14.0"   \
											label.y_offset=2                  \
											update_freq=60                    \
											script="$PLUGIN_DIR/weather.sh"
