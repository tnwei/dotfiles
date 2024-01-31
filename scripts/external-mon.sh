#!/bin/bash
# Edited from https://bobbys.zone/guides/hyprland-clamshell
# This script is designed to be launched once
# Can it be that it is not suitable to be used in IPC?
# Whole thing works properly now! Just need to resolve the broken pipe
# in socket2-mon.sh

HYPRCTL_MONITORS=$(hyprctl monitors -j)
NUM_MONITORS=$(jq "length" <<< $HYPRCTL_MONITORS)

# Actually are monitor descriptions
MONITOR_NAMES=$(jq -r " .[] | .description" <<< $HYPRCTL_MONITORS)
DEFAULT_MONITOR="eDP-1"

# echo $1 $NUM_MONITORS $MONITOR_NAMES

# Parse "hyprctl monitors" output
case $NUM_MONITORS in
    0)
        # I don't think this is triggering ever
        hyprctl keyword monitor "$DEFAULT_MONITOR,preferred,0x0,1.15"
        notify-send "Laptop monitor reactivated"
        ;;
    1)
        if [[ $MONITOR_NAMES == *"Headless"* ]]; then
            hyprctl keyword monitor "$DEFAULT_MONITOR,preferred,0x0,1.15"
            notify-send "Laptop monitor reactivated"
        fi
        ;;
    *)
        case $MONITOR_NAMES in 
            # Turn off laptop screen if connected to work monitor
            *"P2419H"*)
                hyprctl keyword monitor "$DEFAULT_MONITOR,disable"
                notify-send "Dell work monitor detected"
                ;;
            *"E24 G5"*)
                hyprctl keyword monitor "$DEFAULT_MONITOR,disable"
                notify-send "HP work monitor detected"
                ;;
            *"KG241Q P"*)
                hyprctl keyword monitor "$DEFAULT_MONITOR,disable"
                notify-send "Home monitor detected"
                ;;
        esac
esac


