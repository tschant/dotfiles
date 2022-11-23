#!/usr/bin/env bash
source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

sound_change() {
	VOLUME=$(osascript -e "output volume of (get volume settings)")
	MUTED=$(osascript -e "output muted of (get volume settings)")

	COLOR="$WHITE"
	if [[ $MUTED != "false" ]]; then
		ICON="ﱝ"
		COLOR="$GREY"
	else
		case ${VOLUME} in
			100) ICON="";;
			9[0-9])
				ICON=""
				COLOR="$RED"
				;;
			8[0-9])
				ICON=""
				COLOR="$RED"
				;;
			7[0-9])
				ICON=""
				COLOR="$YELLOW"
				;;
			6[0-9])
				ICON=""
				COLOR="$YELLOW"
				;;
			5[0-9])
				ICON=""
				COLOR="$YELLOW"
				;;
			4[0-9])
				ICON=""
				COLOR="$GREEN"
				;;
			3[0-9])
				ICON=""
				COLOR="$GREEN"
				;;
			2[0-9])
				ICON=""
				COLOR="$GREEN"
				;;
			1[0-9])
				ICON=""
				COLOR="$GREEN"
				;;
			[0-9]) 
				ICON=""
				COLOR="$GREEN"
				;;
			*)
				ICON=""
				COLOR="$WHITE"
				;;
		esac
	fi

	sketchybar -m \
		--set $NAME icon=$ICON \
		            icon.color="$COLOR" \
		            label="$VOLUME%"
}

case "$SENDER" in
	"forced") sound_change
	;;
  "volume_change") sound_change
  ;;
esac
