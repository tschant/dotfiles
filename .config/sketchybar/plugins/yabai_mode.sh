#! /usr/bin/env sh
source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

MODE=$($HOME/.local/bin/set_yabai_mode.sh --query | jq -r '.mode')
COLOR=$($HOME/.local/bin/set_yabai_mode.sh --query | jq -r '.color')

COLOR=$(echo $COLOR | tr '[:lower:]' '[:upper:]')
sketchybar_bottom --set yabai_mode label="$MODE" label.color="${!COLOR}"
