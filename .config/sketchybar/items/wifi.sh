#!/usr/bin/env sh

sketchybar --add item wifi right                        \
           --set wifi icon=cal                          \
											icon.font="$FONT:Semibold:14.0"   \
											icon.padding_left=5               \
											icon.padding_right=5              \
											label.align=right                 \
											label.font="$FONT:Regular:14.0"   \
											update_freq=30                    \
											script="$PLUGIN_DIR/wifi.sh"
