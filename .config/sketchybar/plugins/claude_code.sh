#!/usr/bin/env bash
source "$HOME/.config/sketchybar/colors.sh"

update() {
  local json
  json=$($HOME/.cargo/bin/recon json 2>/dev/null)

  if [[ -z "$json" ]]; then
    sketchybar --set claude_code label="0" label.color="$GREY" icon.color="$GREY"
    return
  fi

  local total needs_attention
  total=$(echo "$json" | jq '.sessions | length')
  working=$(echo "$json" | jq '[.sessions[] | select(.status == "Working")] | length')
  needs_attention=$(echo "$json" | jq '[.sessions[] | select(.status == "Input")] | length')

  if [[ "$total" -eq 0 ]]; then
    sketchybar --set claude_code label="0 " label.color="$GREY" icon.color="$GREY"
  elif [[ "$needs_attention" -gt 0 ]]; then
    sketchybar --set claude_code label="$total ●" label.color="$YELLOW" icon.color="$YELLOW"
  elif [[ "$working" -gt 0 ]]; then
    sketchybar --set claude_code label="$total " label.color="$GREEN" icon.color="$GREEN"
  else
    sketchybar --set claude_code label="$total ●" label.color="$GREY" icon.color="$GREY"
  fi
}

populate_popup() {
  local args=()
  args+=(--remove '/claude_code.session\.*/')

  local json
  json=$($HOME/.cargo/bin/recon json 2>/dev/null)

  if [[ -z "$json" ]]; then
    sketchybar -m "${args[@]}" > /dev/null
    return
  fi

  local n
  n=$(echo "$json" | jq '.sessions | length')

  for i in $(seq 0 $((n - 1))); do
    local status tmux_session context_display color
    status=$(echo "$json"         | jq -r ".sessions[$i].status")
    tmux_session=$(echo "$json"   | jq -r ".sessions[$i].tmux_session")
    context_display=$(echo "$json" | jq -r ".sessions[$i].context_display")

    case "$status" in
      "Working") color="$GREEN"  ;;
      "Input")   color="$YELLOW" ;;
      "Idle")    color="$YELLOW" ;;
      "New")     color="$GREY"   ;;
      *)         color="$GREY"   ;;
    esac

    local idx=$((i + 1))
    args+=(--clone "claude_code.session.$idx" claude_code.template       \
           --set   "claude_code.session.$idx"                             \
                   icon="$status"                                         \
                   icon.color="$color"                                    \
                   label="$tmux_session · $context_display"              \
                   position=popup.claude_code                             \
                   drawing=on)
  done

  sketchybar -m "${args[@]}" > /dev/null
}

popup() {
  local drawing
  drawing=$(sketchybar --query claude_code | jq -r '.popup.drawing')
  if [[ "$drawing" != "on" ]]; then
    populate_popup
  fi
  sketchybar --set claude_code popup.drawing="$1"
}

case "$SENDER" in
  "routine"|"forced")    update ;;
  "mouse.entered")       popup on ;;
  "mouse.exited.global") popup off; update ;;
esac
