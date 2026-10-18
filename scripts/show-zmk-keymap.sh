#!/usr/bin/env bash
set -euo pipefail

# Desktop launchers may not load the shell PATH that includes user tools.
export PATH="$HOME/.local/bin:$HOME/.local/scripts:${PATH:-/usr/local/bin:/usr/bin:/bin}"

config_dir="${ZMK_CONFIG_DIR:-$HOME/zmk-config}"
keymap_file="${ZMK_KEYMAP_FILE:-$config_dir/config/totem.keymap}"
layout_json="${ZMK_LAYOUT_JSON:-$config_dir/boards/shields/totem/totem_layout.json}"

for command_name in keymap loupe; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$command_name" >&2
        exit 127
    fi
done

if [[ ! -r "$keymap_file" ]]; then
    printf 'Cannot read ZMK keymap: %s\n' "$keymap_file" >&2
    exit 1
fi

if [[ ! -r "$layout_json" ]]; then
    printf 'Cannot read keyboard layout: %s\n' "$layout_json" >&2
    exit 1
fi

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zmk-keymap"
mkdir -p -- "$cache_dir"
svg_file="$cache_dir/totem.svg"

keymap parse -z "$keymap_file" \
    | keymap draw -j "$layout_json" -l LAYOUT - > "$svg_file"

loupe "$svg_file"
