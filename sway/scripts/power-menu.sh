#!/bin/bash

# Options
shutdown=" Shutdown"
reboot=" Reboot"
suspend=" Suspend"

# Rofi CMD
chosen=$(echo -e "$shutdown\n$reboot\n$suspend" | rofi -dmenu -i -p "Power Menu" \
  -location 1 -yoffset 30 -theme-str '* { font: "Hack Nerd Font 12"; } window { anchor: north east; location: northeast; width: 200px; height: 120px; } listview { lines: 3; }') > /dev/null 2>&1

case "$chosen" in
    "$shutdown") systemctl poweroff ;;
    "$reboot") systemctl reboot ;;
    "$suspend") systemctl suspend ;;
esac
