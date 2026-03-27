#!/usr/bin/env sh

POPUP_CLICK_SCRIPT="sketchybar --set claude_code popup.drawing=toggle"


if [ -x "$HOME/.cargo/bin/recon" ] && [ -x "$HOME/.local/bin/claude" &>/dev/null ]; then
	sketchybar --add item claude_code right \
						 --set claude_code icon=""                                       \
															 label="0"                                      \
															 label.color=$GREY                              \
															 icon.color=$GREY                               \
															 update_freq=5                                  \
															 script="$PLUGIN_DIR/claude_code.sh"           \
															 click_script="$POPUP_CLICK_SCRIPT"            \
						 --subscribe claude_code mouse.entered                           \
																		 mouse.exited                            \
																		 mouse.exited.global                     \
						 --add  item            claude_code.template popup.claude_code   \
						 --set  claude_code.template drawing=off                          \
																				 background.corner_radius=12         \
																				 padding_left=7                      \
																				 padding_right=7
else 
	exit 0
fi
