#!/bin/bash
# Rofi File Search Script
#
# This script searches for files and directories in the home folder and opens the selection.
# It prioritizes indexed search (plocate) for "Spotlight-like" speed.
#
# It uses your 'neon-theme.rasi' but overrides the layout to be a vertical list
# instead of a horizontal power menu.

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

# The directory to search in.
SEARCH_DIR="$HOME"

# The prompt to show in rofi.
PROMPT="Search System"

# Path to your custom Rofi theme.
THEME_PATH="$HOME/.config/rofi/search-theme.rasi"

# -----------------------------------------------------------------------------
# Search Logic
# -----------------------------------------------------------------------------

# Function to retrieve the list of directories using the fastest available method
generate_list() {
    # 1. Try fd (Fast, real-time)
    if command -v fd &> /dev/null; then
        fd --type d . "$SEARCH_DIR"
        return
    fi

    # 2. Fallback to find (Standard, slower real-time)
    find "$SEARCH_DIR" -type d
}

# -----------------------------------------------------------------------------
# Main Execution
# -----------------------------------------------------------------------------

# Run the search and pipe results to rofi.
# We apply the dedicated search theme which handles layout and colors.
selected=$(generate_list | rofi -dmenu -i -p "$PROMPT" \
    -theme "$THEME_PATH" \
    -show-icons)

# If a selection was made, open it.
if [ -n "$selected" ]; then
    nemo "$selected"
fi
