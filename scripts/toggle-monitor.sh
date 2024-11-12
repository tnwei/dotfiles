#!/bin/bash
HYPRCTL_MONITORS=$(hyprctl monitors -j)
MONITOR_NAMES=$(jq -r " .[] | .description, .name" <<< $HYPRCTL_MONITORS)
DEFAULT_MONITOR="eDP-1"

if [[ $MONITOR_NAMES == *"$DEFAULT_MONITOR"* ]]; then
    hyprctl keyword monitor "$DEFAULT_MONITOR,disable"
    notify-send "Laptop monitor disabled"
else
    hyprctl keyword monitor "$DEFAULT_MONITOR,preferred,0x0,1"
    notify-send "Laptop monitor reactivated"
fi
