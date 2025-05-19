#!/bin/bash

# Get selection area from slurp
SELECTION=$(slurp)

# Check if the selection was cancelled
if [ -z "$SELECTION" ]; then
    dunstify "Screenshot cancelled"
    exit 1
fi

# Define file paths
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
SAVE_PATH=~/Screenshots/${TIMESTAMP}_screenshot.png
TMP_PATH=/tmp/screenshot.png

# Take screenshot, save and copy to clipboard
grim -g "$SELECTION" "$TMP_PATH" && \
    cp "$TMP_PATH" "$SAVE_PATH" && \
    wl-copy < "$TMP_PATH" && \
    dunstify -i "$TMP_PATH" "Screenshot Taken" "Saved to $SAVE_PATH and copied to clipboard"
