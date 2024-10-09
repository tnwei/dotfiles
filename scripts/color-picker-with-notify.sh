#!/bin/bash
# TODO: if launched via rofi, the rofi launcher is on screen while color picking
notify-send "Color picker active"
color=$(hyprpicker)

# Check if $color is empty (user cancelled)
if [ -n "$color" ]; then
  notify-send "Color picked and copied to clipboard" "$color"
fi
