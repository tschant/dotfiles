#!/usr/bin/env sh

FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

sketchybar --add       event        window_focus                     \
           --add       event        windows_on_spaces                \
           --add       item         system.yabai left                \
           --set       system.yabai script="$PLUGIN_DIR/yabai.sh"    \
                                    icon.width=18                    \
																		icon.font="$FONT:Regular:14.0" \
																		label.width=18 \
                                    updates=on                       \
                                    associated_display=active        \
           --subscribe system.yabai window_focus                     \
                                    windows_on_spaces                \
                                                                     \
           --add       item         front_app left                   \
           --set       front_app    script="$FRONT_APP_SCRIPT"       \
                                    icon.drawing=off                 \
                                    background.padding_left=-3        \
                                    background.padding_right=5       \
                                    label.color=$WHITE               \
                                    label.font="$FONT:Semibold:12.0" \
                                    associated_display=active        \
           --subscribe front_app    front_app_switched
