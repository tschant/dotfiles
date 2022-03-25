#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="bottom"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)
# Format of the information displayed
# Eg. {{ artist }} - {{ album }} - {{ title }}
# See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
# PLAYERCTL_FORMAT="{{ title }} - {{ artist }}"
SPT_FORMAT="%a - %t"
SPT_STATUS_FORMAT="%s"

# Sends $2 as message to all polybar PIDs that are part of $1
update_hooks() {
	while IFS= read -r id
	do
		polybar-msg -p "$id" hook player-play-pause $2 1>/dev/null 2>&1
	done < <(echo "$1")
}

SPT_STATUS=$(spt pb -s -f $SPT_STATUS_FORMAT 2>/dev/null)
# PLAYERCTL_STATUS=$(playerctl status 2>/dev/null)
# EXIT_CODE=$?

# if [ $EXIT_CODE -eq 0 ]; then
# 	STATUS=$PLAYERCTL_STATUS
# else
# 	STATUS="No player is running"
# fi

if [ "$1" == "--status" ]; then
	echo "$SPT_STATUS"
else
	if [ "$SPT_STATUS" = "▶" ]; then
		update_hooks "$PARENT_BAR_PID" 1
		spt pb -s -f "$SPT_FORMAT"
	elif [ "$SPT_STATUS" = "⏸" ]; then
		update_hooks "$PARENT_BAR_PID" 2
		spt pb -s -f "$SPT_FORMAT"
	# elif [ "$STATUS" = "Playing" ]; then
	# 	update_hooks "$PARENT_BAR_PID" 1
	# 	playerctl metadata --format "$PLAYERCTL_FORMAT"
	# elif [ "$STATUS" = "Paused"  ]; then
	# 	update_hooks "$PARENT_BAR_PID" 2
	# 	playerctl metadata --format "$PLAYERCTL_FORMAT"
	# elif [ "$STATUS" = "No player is running"  ]; then
	# 	echo "$STATUS"
	else
		echo "No music is playing"
	fi
fi

