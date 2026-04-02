#!/bin/bash

DIR="$1"

# If it's a file, use its parent directory
if [ ! -d "$DIR" ]; then
  DIR=$(dirname "$DIR")
fi

# Derive session name the same way t-smart does
SESSION_NAME=$(echo "$DIR" | sed 's|'"$HOME"'|~|' | tr ' ' '_' | tr '.' '_' | tr ':' '_')
SESSION=$(tmux list-sessions -F '#S' 2>/dev/null | grep "^$SESSION_NAME$")

if [ -n "$TMUX" ]; then
  if [ -z "$SESSION" ]; then
    tmux new-session -d -s "$SESSION_NAME" -c "$DIR"
  fi
  tmux switch-client -t "$SESSION_NAME"
else
  if [ -z "$SESSION" ]; then
    tmux new-session -s "$SESSION_NAME" -c "$DIR"
  else
    tmux attach -t "$SESSION"
  fi
fi
