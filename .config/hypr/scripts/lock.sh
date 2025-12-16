#!/bin/sh
#
# lock.sh - Blurs the wallpaper and uses it as a lock screen.
# This version avoids screenshotting for maximum stability.
#

# --- CONFIGURATION ---
# The path to your original wallpaper.
WALLPAPER="/home/moonboyknm/Pictures/wallpapers/LecSF25.png"

# The temporary file to store the blurred wallpaper.
TMP_IMG="/tmp/screenlock_wallpaper.png"


# --- SCRIPT ---

# 1. Create a blurred version of the wallpaper.
# We copy the original wallpaper to a temporary file and then blur it.
magick "$WALLPAPER" -blur 10x10 "$TMP_IMG"

# 2. Lock the screen with swaylock, using the blurred image.
# The indicator ring is bigger and the time is in 24-hour format.
XKB_DEFAULT_LAYOUT=us swaylock \
    --image "$TMP_IMG" \
    --clock \
    --indicator \
    --indicator-radius 180 \
    --indicator-thickness 10 \
    --time-str "%H:%M" \
    --ring-color 000000 \
    --key-hl-color ff0000 \
    --line-color 00000000 \
    --inside-color 00000088 \
    --separator-color 00000000 \
    --text-color ffffff \
    --grace 2 \
    --fade-in 0.5

# 3. Remove the temporary blurred file after unlocking.
rm "$TMP_IMG"

