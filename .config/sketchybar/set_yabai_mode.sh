#! /usr/bin/env sh

# make sure to fix permissions!
# Privacy & Security > Automation > skhd > Ubersicht

# Write information regarding skhd mode to a cache file for widgets to read from.
# Usage:
#   $0 --query              print location of cache file
#   $0 mode_name [color]    write mode_name (and optionally, a color) to a cache file
#                           default color is white.
#                           by default, a mode named "default" will not be shown.

CACHE_FILE="$HOME/.local/share/sketchybar/yabai-mode"

mkdir -p "$(dirname "$CACHE_FILE")"
touch "$CACHE_FILE"

main() {
    # optional second argument color
    color="$2"
    if [ -z "$color" ]; then
        color="white"
    fi

    # update cache file
    echo \
        "{\"mode\": \"$1\", \"color\": \"$color\"}" \
        >"$CACHE_FILE"

    if [ -f "$HOME/.config/sketchybar/plugins/yabai_mode.sh" ]; then
        bash $HOME/.config/sketchybar/plugins/yabai_mode.sh
    fi
}

case "$1" in
--query)
    cat "$CACHE_FILE"
    ;;
*)
    main "$@"
    ;;
esac
