#!/bin/bash

# Options
shutdown=" Shutdown"
reboot=" Reboot"
suspend=" Suspend"

# Rofi CMD
chosen=$(echo -e "$shutdown\n$reboot\n$suspend" | rofi -dmenu -i -p "Power Menu" \
  -location 1 -xoffset 40 \
  -theme-str '* {
    font: "Hack Nerd Font 12";
  }
  window {
    anchor: south west;
    location: southwest;
    width: 200px;
    height: 120px;
    border: 2px;
    border-radius: 6px;
    border-color: rgba(203, 166, 247, 0.3);
  }
  listview {
    lines: 3;
  }') > /dev/null 2>&1

case "$chosen" in
    "$shutdown") systemctl poweroff ;;
    "$reboot") systemctl reboot ;;
    "$suspend") systemctl suspend ;;
esac
