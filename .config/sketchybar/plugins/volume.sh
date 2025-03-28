#!/usr/bin/env sh

WIDTH=100

volume_change() {
	INFO=$(osascript -e "output volume of (get volume settings)")
  INITIAL_WIDTH=$(sketchybar --query $NAME | jq ".icon.width")
  if [ "${INITIAL_WIDTH:-0}" -eq "0" ]; then
    sketchybar --set $NAME width=$WIDTH icon.width=$INFO icon.padding_left="10"
  else
    sketchybar --set $NAME icon.width=$INFO width=$WIDTH icon.padding_left="10"
  fi

  sleep 2
  FINAL_WIDTH=$(sketchybar --query $NAME | jq ".icon.width")
  if [ "$FINAL_WIDTH" -eq "$INFO" ]; then
    sketchybar --set $NAME width=0 icon.width=0
  fi
}

case "$SENDER" in
  "volume_change") volume_change
  ;;
esac
