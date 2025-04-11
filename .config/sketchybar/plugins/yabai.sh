#!/bin/sh

window_state() {
  source "$HOME/.config/sketchybar/colors.sh"
  source "$HOME/.config/sketchybar/icons.sh"

  WINDOW=$(yabai -m query --windows --window)
  CURRENT=$(echo "$WINDOW" | jq '.["stack-index"]')

  args=()
	app=$(echo $WINDOW | jq -r '.["app"]')
	APP_ICON=$($HOME/.config/sketchybar/plugins/icon_map.sh "$app")
  if [[ $CURRENT -gt 0 ]]; then
    LAST=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    args+=(--set $NAME label=$(printf "[%s/%s]" "$CURRENT" "$LAST") icon="$APP_ICON" icon.color=$RED icon.drawing=on)
  else 
    args+=(--set $NAME label.drawing=off)
    case "$(echo "$WINDOW" | jq '.["is-floating"]')" in
      "false")
        if [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
          args+=(--set $NAME icon="$APP_ICON" icon.color=$GREEN icon.drawing=on)
        elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
          args+=(--set $NAME icon="$APP_ICON" icon.color=$BLUE icon.drawing=on)
        else
          args+=(--set $NAME icon="$APP_ICON" icon.color=$CYAN icon.drawing=on)
        fi
        ;;
      "true")
        args+=(--set $NAME icon="$APP_ICON" icon.color=$MAGENTA icon.drawing=on)
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
        echo $app
        icon_strip+=" $($HOME/.config/sketchybar/plugins/icon_map.sh "$app")"
			done

      args+=(--set space.$space label="$icon_strip" label.drawing=on)
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}


case "$SENDER" in
  "forced") window_state && windows_on_spaces
  ;;
  "window_focus") window_state 
  ;;
  "windows_on_spaces") windows_on_spaces
  ;;
esac
