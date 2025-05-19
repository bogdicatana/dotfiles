#!/bin/bash

# Use rofi to select a file from the directory
SELECTED=$(find ~/.config/sway/wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | rofi -dmenu -p "Select Wallpaper")

# If user selected a file
if [ -n "$SELECTED" ]; then
    # Set new wallpaper
    swaybg -i "$SELECTED" -m fill &
fi
