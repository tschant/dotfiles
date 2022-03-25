#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 30 \
	--delay 0.5 \
	--scroll-padding "  " \
	--match-command "`dirname $0`/status.sh --status" \
	--match-text "▶" "--scroll 1" \
	--match-text "Playing" "--scroll 1" \
	--match-text "⏸" "--scroll 0" \
	--match-text "Paused" "--scroll 0" \
	--update-check true "`dirname $0`/status.sh" &

wait
