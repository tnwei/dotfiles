# /bin/bash

# Kill existing swaybg
kill $(pgrep -f swaybg) 2>/dev/null

# Launches swaybg from random selection of files in ~/wallpapers
# Taking care to exclude the README file
swaybg -i $(find ~/wallpapers/. -type f ! -name '*.md' | shuf -n1) &

# Disowns the swaybg process
disown $!
