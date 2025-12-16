#!/bin/bash

# Get the title of the Spotify window using hyprctl and jq
SPOTIFY_WINDOW_TITLE=$(hyprctl clients -j | jq -r '.[] | select(.class == "Spotify") | .title')

# If the title is not empty, print it
if [ -n "$SPOTIFY_WINDOW_TITLE" ]; then
    echo "$SPOTIFY_WINDOW_TITLE"
fi
