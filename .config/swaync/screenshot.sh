#!/bin/sh

# Hide the notification center
swaync-client -t -sw &
sleep 0.1

# Take the screenshot using hyprshot
hyprshot -m 'region' -o "$HOME/Pictures/Screenshots"
