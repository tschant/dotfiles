sketchybar --add item volume right                      \
           --set volume script="$PLUGIN_DIR/volume.sh"  \
                        updates=on                      \
                        icon.background.drawing=on      \
                        icon.background.color=$BLUE     \
                        icon.background.height=8        \
                        icon.background.corner_radius=3 \
                        icon.width=0                    \
                        icon.align=right                \
                        label.drawing=off               \
                        background.drawing=on           \
                        background.color=$BACKGROUND_2  \
                        background.height=8             \
                        background.corner_radius=0      \
                        align=left                      \
           --subscribe volume volume_change

sketchybar --add item sound right                                  \
           --set sound icon.drawing=on                             \
											 label.drawing=on                            \
											 label.color=$WHITE                          \
											 background.padding_right=5                  \
											 background.padding_left=10                  \
											 align=right                                 \
											 script="$PLUGIN_DIR/sound.sh"               \
											 click_script="$PLUGIN_DIR/volume_click.sh"  \
           --subscribe sound volume_change
