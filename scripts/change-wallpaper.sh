# /bin/bash

if command -v swaybg >/dev/null 2>&1; then
    # Kill existing swaybg
    kill $(pgrep -f swaybg) 2>/dev/null

    # Launches swaybg from random selection of files in ~/wallpapers
    # Taking care to exclude the README file
    swaybg -i $(find ${HOME}/wallpapers/. -type f ! -name '*.md' | shuf -n1) &

    # Disowns the swaybg process
    disown $!
elif command -v wal >/dev/null 2>&1 && command -v feh >/dev/null 2>&1; then
    # If swaybg is not installed, check for pywal and feh
    wal -i ${HOME}/wallpapers/ -n
    feh --bg-fill "$(< "${HOME}/.cache/wal/wal")"
else
    echo "Neither swaybg, nor both pywal and feh are installed. Doing nothing."
fi
