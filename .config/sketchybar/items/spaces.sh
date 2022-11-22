#!/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "1" "2" "3" "4" "5")
SPACE_CLICK_SCRIPT="echo \$SID"

sid=0
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space      space.$sid left                               \
             --set space.$sid associated_space=$sid                         \
                              icon=${SPACE_ICONS[i]}                        \
                              icon.padding_left=14                          \
                              icon.padding_right=14                         \
                              icon.highlight_color=$CYAN                    \
                              background.padding_left=-8                    \
                              background.padding_right=0                    \
                              background.color=$BACKGROUND_1                \
                              background.drawing=on                         \
                              label.padding_right=24                        \
                              label.font="sketchybar-app-font:Regular:14.0" \
															label.color=$WHITE                            \
                              label.background.height=26                    \
                              label.background.drawing=on                   \
                              label.background.color=$BACKGROUND_2          \
                              label.background.corner_radius=0              \
                              label.drawing=off                             \
                              script="$PLUGIN_DIR/space.sh"                 \
                              click_script="$PLUGIN_DIR/space_click.sh \$SID"
done

sketchybar   --add item       separator left                          \
             --set separator  icon=⎹                                  \
                              icon.font="$FONT:Regular:16.0"          \
                              background.padding_left=18              \
                              background.padding_right=0              \
                              label.drawing=off                       \
															label.font="$FONT:Regular:13.0"         \
                              associated_display=active               \
                              icon.color=$WHITE
