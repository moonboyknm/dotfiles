#!/bin/sh

# Hide swaync first to prevent it from being captured
#swaync-client -t -sw &
#sleep 0.1

# Take the screenshot and save it directly to the Pictures/Screenshots directory
grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
