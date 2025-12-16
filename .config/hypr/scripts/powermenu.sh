#!/bin/bash

# Define the options with icons
options="󰜬 Reboot\n󰐥 Shutdown"

# Show the menu with Wofi
# --dmenu mode reads from stdin and outputs the selection to stdout
# -i case insensitive
# --matching=fuzzy allows 's' to match 'Shutdown'
# Search bar is hidden via CSS but still functional
# Press 's' then Enter to shutdown quickly
selected_option=$(echo -e "$options" | wofi --dmenu -i --matching=fuzzy --prompt="Power Menu" --style=$HOME/.config/wofi/style.css --width=300 --height=120 --hide-scroll)

# Execute the command based on the selection
case "$selected_option" in
    "󰜬 Reboot")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
esac
