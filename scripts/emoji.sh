#!/bin/bash

# Inspiration:
# https://www.reddit.com/r/unixporn/comments/c6i0f6/i3_custom_emoji_selector_menu_with_rofi/

EMOJIS_PATH="$HOME/.local/scripts/list-emoji.txt"
# line=`cat $EMOJIS_PATH | wofi --dmenu --width=60% --height=60% --insensitive -n --prompt "" --matching=fuzzy --columns 2 --style style.css`
# line=$(cat $EMOJIS_PATH | wofi --dmenu --width=60% --height=60% --insensitive -n --prompt "" --matching=fuzzy --columns 2)
line=$(cat $EMOJIS_PATH | fuzzel --dmenu --use-bold --width 50 --match-mode=fzf)

echo $line

emoji=$(echo "$line" | awk -F',' '{print $NF}')
# emoji=$(echo "$line" | rev | cut -d, -f1 | rev)
# emoji=${line: -1}

if [[ ! -z "$emoji" ]]; then
	wl-copy $emoji
	notify-send "$emoji copied" -t 500

	# TODO: wl-paste pipes to stdout but not to cursor
	# wl-paste
fi

# EMOJIS_PATH="$HOME/.config/rofi/emoji-list"
# line=`cat $EMOJIS_PATH | rofi -dmenu -theme emoji-selector-theme -i -markup-rows -p "" -columns 6`
# [[ -z $line ]] && exit
# a="${line#*>}"
# b="${a%<*}"
# echo -n $b | xsel -ipb
# xdotool key Ctrl+Shift+v
