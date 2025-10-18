#!/bin/bash
SESSION_NAME="ghostty"

TMUX_CMD=/usr/local/bin/tmux
if [[ "$OS_NAME" =~ "Darwin" ]]; then
 TMUX_CMD=/opt/homebrew/bin/tmux
fi

# Check if the session already exists
$TMUX_CMD has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
 # If the session exists, reattach to it
 $TMUX_CMD attach-session -t $SESSION_NAME
else
 # If the session doesn't exist, start a new one
 $TMUX_CMD new-session -s $SESSION_NAME -d
 $TMUX_CMD attach-session -t $SESSION_NAME
fi
