#!/bin/bash
# Modifed from
# https://github.com/luispabon/sway-dotfiles/blob/master/scripts/wofi-power.sh
# Icon names from
# https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html

# Check if rofi or wofi is installed in the first place
if command -v fuzzel &> /dev/null; then
    LAUNCHER="fuzzel"
else
    echo "Error: fuzzel is not found in PATH."
    exit 1
fi

# How to check if no params provided to a bash script
# https://unix.stackexchange.com/a/25947
if [ $# -eq 0 ]; then
	ENTRIES=" Lock\n Logout\n Suspend\n Reboot\n Shutdown"
	SELECTED=$(echo -e $ENTRIES | $LAUNCHER --prompt "Power Menu -> " --use-bold --dmenu --cache /dev/null | awk '{print tolower($2)}')
else
	SELECTED=$1
fi

case $SELECTED in
lock)
    hyprlock
	;;
logout)
	if zenity --question --icon system-log-out --title="Logout"; then
		hyprctl dispatch exit
	fi
	;;
suspend)
    # Skip confirmation for sleep, just like locking screen
    systemctl suspend
	;;
reboot)
	if zenity --question --icon system-reboot --title="Reboot"; then
		systemctl reboot
	fi
	;;
shutdown)
	if zenity --question --icon system-shutdown --title="Shutdown"; then
		systemctl poweroff -i
	fi
	;;
*)
	echo "\$1 accepted are lock, logout, suspend, reboot and shutdown"
	;;
esac
