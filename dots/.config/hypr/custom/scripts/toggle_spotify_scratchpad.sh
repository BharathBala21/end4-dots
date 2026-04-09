#!/usr/bin/env bash

SCRATCHPAD="spotify"

# Check if Spotify exists inside special:spotify
CLIENTS=$(hyprctl clients -j | python3 -c "
import sys, json
clients = json.load(sys.stdin)
found = [c for c in clients if c['workspace']['name'] == 'special:$SCRATCHPAD']
print(len(found))
")

if [ "$CLIENTS" -eq 0 ]; then
    # Not in scratchpad at all — launch it there
    hyprctl dispatch exec "[workspace special:$SCRATCHPAD silent]" spotify
else
    # Already there — just toggle visibility
    hyprctl dispatch togglespecialworkspace "$SCRATCHPAD"
fi
