#!/usr/bin/env sh

sketchybar_bottom -m --add item yabai_mode right \
                             --subscribe yabai_mode front_app_switched \
                             --set yabai_mode update_freq=0 \
                             updates=on \
                             label="default" \
                             label.font="$FONT:Regular:14.0" \
                             label.color=$WHITE \
                             script="$PLUGIN_DIR/yabai_mode.sh"
