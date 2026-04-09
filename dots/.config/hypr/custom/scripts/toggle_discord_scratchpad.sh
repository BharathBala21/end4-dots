#!/usr/bin/env bash

SCRATCHPAD="discord"

CLIENTS=$(hyprctl clients -j | python3 -c "
import sys, json
clients = json.load(sys.stdin)
found = [c for c in clients if c['workspace']['name'] == 'special:$SCRATCHPAD']
print(len(found))
")

if [ "$CLIENTS" -eq 0 ]; then
    hyprctl dispatch exec "[workspace special:$SCRATCHPAD silent]" discord
else
    hyprctl dispatch togglespecialworkspace "$SCRATCHPAD"
fi
