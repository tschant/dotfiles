#!/usr/bin/env sh

sketchybar -m --add item battery right                    \
              --set battery update_freq=3                 \
              --set battery script="$PLUGIN_DIR/power.sh" \
              --set battery icon=
