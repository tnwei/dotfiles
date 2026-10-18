#!/usr/bin/env bash
# Screenshot region -> tesseract OCR -> clipboard + notification
set -euo pipefail

GEOM=$(slurp -d) || exit 0  # user cancelled slurp
TEXT=$(grim -g "$GEOM" - | tesseract - - 2>/dev/null)

if [[ -z "${TEXT// /}" ]]; then
    notify-send -t 3000 "OCR" "No text found" -i dialog-warning
    exit 0
fi

echo -n "$TEXT" | wl-copy
notify-send -t 3000 "OCR" "Copied to clipboard" -i clipboard
