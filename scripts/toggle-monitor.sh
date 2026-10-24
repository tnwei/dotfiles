#!/bin/bash
HYPRCTL_MONITORS=$(hyprctl monitors -j) || exit 1
DEFAULT_MONITOR="eDP-1"

if jq -e --arg name "$DEFAULT_MONITOR" 'any(.[]; .name == $name)' <<< "$HYPRCTL_MONITORS" >/dev/null; then
    hyprctl eval "hl.monitor({ output = \"$DEFAULT_MONITOR\", disabled = true })"
    notify-send "Laptop monitor disabled"
else
    hyprctl eval "hl.monitor({ output = \"$DEFAULT_MONITOR\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1 })"
    notify-send "Laptop monitor reactivated"
fi
