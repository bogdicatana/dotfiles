#!/bin/bash

# Get today's day (without leading 0)
today=$(date +"%e" | sed 's/ *//')

# Get calendar and highlight today by wrapping it in brackets
calendar=$(cal | awk 'NF' | sed "s/\b$today\b//")


# Show in rofi
echo "$calendar" | rofi -dmenu -p "Calendar" \
  -location 1 -xoffset 40 \
  -theme-str '* {
    font: "Hack Nerd Font Mono 12";
  }
  window {
    anchor: north west;
    location: northwest;
    width: 230px;
    height: 200px;
    border: 2px;
    border-radius: 6px;
    border-color: rgba(203, 166, 247, 0.3);
} listview { lines: 7; }' > /dev/null 2>&1
