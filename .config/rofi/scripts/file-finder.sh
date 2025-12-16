#!/bin/bash

# This script finds files AND directories in your home directory and opens your selection.
# It automatically uses your existing rofi theme.

# The directory to search in.
SEARCH_DIR="$HOME"
# The prompt to show in rofi.
PROMPT="Search System"

# Use the 'fd' command if it exists. It finds files and directories by default.
# Otherwise, fall back to the standard 'find' command.
if command -v fd &> /dev/null; then
    # No --type flag means fd finds both files and directories.
    selected=$(fd . "$SEARCH_DIR" | rofi -dmenu -i -p "$PROMPT")
else
    # This tells find to look for items that are a file (-type f) OR a directory (-type d).
    selected=$(find "$SEARCH_DIR" \( -type f -o -type d \) | rofi -dmenu -i -p "$PROMPT")
fi

# If an item was selected (and the user didn't cancel rofi),
# open it using the default application (xdg-open).
# xdg-open will open a directory in the default file manager (like Nautilus).
if [ -n "$selected" ]; then
  xdg-open "$selected"
fi