#!/bin/sh

window_state() {
  source "$HOME/.config/sketchybar/colors.sh"
  source "$HOME/.config/sketchybar/icons.sh"

  WINDOW=$(yabai -m query --windows --window)
  CURRENT=$(echo "$WINDOW" | jq '.["stack-index"]')

  args=()
	app=$(yabai -m query --windows --window | jq -r '.["app"]')
	APP_ICON=$($HOME/.config/sketchybar/plugins/icon_map.sh "$app")
  if [[ $CURRENT -gt 0 ]]; then
    LAST=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    args+=(--set $NAME label="$APP_ICON" icon=$YABAI_STACK icon.color=$RED label.color=$RED label.drawing=on label=$(printf "[%s/%s]" "$CURRENT" "$LAST"))
  else 
    args+=(--set $NAME label.drawing=off)
    case "$(echo "$WINDOW" | jq '.["is-floating"]')" in
      "false")
        if [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
          args+=(--set $NAME label="$APP_ICON" label.drawing=on icon=$YABAI_FULLSCREEN_ZOOM label.color=$GREEN icon.color=$GREEN)
        elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
          args+=(--set $NAME label="$APP_ICON" label.drawing=on icon=$YABAI_PARENT_ZOOM label.color=$BLUE icon.color=$BLUE)
        else
          args+=(--set $NAME label="$APP_ICON" label.drawing=on icon=$YABAI_GRID label.color=$CYAN icon.color=$CYAN)
        fi
        ;;
      "true")
        args+=(--set $NAME label="$APP_ICON" label.drawing=on icon=$YABAI_FLOAT label.color=$MAGENTA icon.color=$MAGENTA)
        ;;
    esac
  fi

  sketchybar -m "${args[@]}"
}

windows_on_spaces () {
  CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

  args=()
  while read -r line
  do
    for space in $line
    do
      icon_strip=" "
			windows=$(yabai -m query --windows --space $space)
			app_count=$(echo "$windows" | jq ". | length")

			for ((i=0; i<$app_count; i++)); do
				app=`echo "$windows" | jq -r '.['"$i"'].app'`
        icon_strip+=" $($HOME/.config/sketchybar/plugins/icon_map.sh "$app")"
			done

      args+=(--set space.$space label="$icon_strip" label.drawing=on)
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}


case "$SENDER" in
  "forced") exit 0
  ;;
  "window_focus") window_state 
  ;;
  "windows_on_spaces") windows_on_spaces
  ;;
esac
