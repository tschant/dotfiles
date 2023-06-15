#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh" # Loads all defined icons
# This function takes an integer as argument which represents a day. 
# 0 is today, 1 is tomorrow, 2 the day after tomorrow etc...
list_events() { 
	source "$HOME/.config/sketchybar/colors.sh"
	SEP="%"
	local args=$2
	EVENT_COUNT=0
	if [ "$1" == "" ] || [ "$1" == "args" ]; then
		DAY_COUNT=0
	else
		DAY_COUNT=$1
	fi
	args+=(--remove '/ical.day\.*/')
	args+=(--remove '/ical.event\.*/')

	# Displays the day in the first row of the list
	DATE=$(date -v+${DAY_COUNT}d +"%d.%b")
	args+=(--clone ical.day.$DAY_COUNT ical.template                                     \
			--set ical.day.$DAY_COUNT icon="$(date -v+${DAY_COUNT}d +"%a %d. %b")"           \
					icon.color=$GREEN                                                            \
					click_script="sketchybar --set $NAME popup.drawing=off"                      \
					position=popup.ical                                                          \
					drawing=on)
	if [ "${DAY_COUNT}" == "0" ];then
			args+=(--set ical.day.$DAY_COUNT icon="$(date '+%a %d. %b - %H:%M:%S')")
			EVENTS="$(icalBuddy -eed -n -nc -nrd -npn -ea -df "" -tf "%H.%M" -iep datetime,title -b '' -ps "|$SEP|" eventsFrom:$DATE to:$DATE)"
	else
			args+=(--set ical.day.$DAY_COUNT drawing=on)
			EVENTS="$(icalBuddy -eed -nc -nrd -npn -ea -df "" -tf "%H.%M" -iep datetime,title -b '' -ps "|$SEP|" eventsFrom:$DATE to:$DATE)"
	fi

	# Displays the events of the day (time and title)
	while read -r line; do
			((EVENT_COUNT++))
			if [ "${line}" != "" ]; then
					line=$(echo $line | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g")
					IFS="${SEP}" read -ra event_parts <<< "$line"
					time="${event_parts[1]}"
					title="${event_parts[0]}"
			else
					time="No events"
					title=":)"
			fi
			args+=(--clone ical.event.$EVENT_COUNT ical.template \
							--set ical.event.$EVENT_COUNT label="$title"    \
							icon="$time"            \
							icon.color=$YELLOW \
							click_script="sketchybar --set $NAME popup.drawing=off" \
							position=popup.ical
			drawing=on)
	done <<< "$(echo "$EVENTS")"
}

mouse_clicked() {
	local args=()
	DAY_COUNT=$(sketchybar --query ical | jq -r '.popup.items[] | select(startswith("ical.day.")) | split(".")[-1]')
	if [ "$BUTTON" = "left" ]; then
		((DAY_COUNT++))
	else
		if [ $DAY_COUNT -gt 0 ]; then
			((DAY_COUNT--))
		else
			return 
		fi
	fi
	list_events $DAY_COUNT args
	sketchybar -m "${args[@]}" > /dev/null
}


update() {
	sketchybar --set $NAME icon="$CALENDAR $(date '+%a %d. %b')" label=" $(date '+%I:%M %p')"
}

popup() {
	local args=()
	DRAWING=$(sketchybar --query ical | jq -r '.popup.drawing')
	if [[ "$DRAWING" != "on" ]]; then
		DAY_COUNT=$(sketchybar --query ical | jq -r '.popup.items[] | select(startswith("ical.day.")) | split(".")[-1]')
		list_events $DAY_COUNT args
		sketchybar -m "${args[@]}" > /dev/null
	fi
	sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
	"routine"|"forced") update
			;;
	"mouse.entered") popup on
			;;
	"mouse.exited.global") popup off;update
			;;
	"mouse.clicked") mouse_clicked
			;;
esac
