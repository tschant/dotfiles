#!/usr/bin/env sh

SSID=$(python3 -c "
import subprocess, re
r = subprocess.run(['scutil'], input='show State:/Network/Interface/en0/AirPort\n', capture_output=True, text=True)
m = re.search(r'46([0-9a-f]+)56\1', r.stdout)
if m: print(bytes.fromhex(m.group(1)).decode('utf-8', errors='ignore'))
" 2>/dev/null)

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="Disconnected" icon=󰖪
else
  TX_RATE=$(system_profiler SPAirPortDataType 2>/dev/null | grep "Transmit Rate" | head -1 | awk '{print $3}')
  if [ -n "$TX_RATE" ]; then
    sketchybar --set $NAME label="$SSID (${TX_RATE}Mbps)" icon=󰖩
  else
    sketchybar --set $NAME label="$SSID" icon=󰖩
  fi
fi
