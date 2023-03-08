#!/usr/bin/env sh

POPUP_CLICK_SCRIPT="sketchybar --set ical popup.drawing=toggle"

sketchybar --add item             ical right                    \
           --set ical             icon=cal                          \
                                  icon.font="$FONT:Semibold:14.0"   \
                                  icon.padding_left=0               \
                                  icon.padding_right=10             \
                                  label.width=100                   \
                                  label.align=right                 \
                                  label.font="$FONT:Regular:14.0"   \
                                  background.padding_left=15        \
                                  update_freq=30                    \
                                  script="$PLUGIN_DIR/ical.sh"      \
                                  click_script="$POPUP_CLICK_SCRIPT"\
           --subscribe ical       mouse.clicked                     \
                                  mouse.entered                     \
                                  mouse.exited                      \
                                  mouse.exited.global               \
           --add  item            ical.template popup.ical           \
           --set  ical.template   drawing=off                        \
                                  background.corner_radius=12        \
                                  padding_left=7                     \
                                  padding_right=7                    \
                                  icon.background.height=2           \
                                  icon.background.y_offset=-12
