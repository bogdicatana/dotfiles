#!/bin/bash

# Enable click support
echo '{"version":1, "click_events": true}'
echo '['
echo '[],'

WEATHER_FILE="/tmp/weather.txt"
echo "N/A" > "$WEATHER_FILE"  # initialize with default

make_bar() {
    local PERCENT=$1
    local SIZE=10
    local FILLED=$((PERCENT * SIZE / 100))
    local EMPTY=$((SIZE - FILLED))
    local BAR=""
    if (( FILLED > 0 )); then
        BAR+=$(printf "%0.s█" $(seq 1 $FILLED))
    fi

    if (( EMPTY > 0 )); then
        BAR+=$(printf "%0.s░" $(seq 1 $EMPTY))
    fi
    echo "$BAR"
}


get_player_status() {
    if playerctl status &>/dev/null; then
        STATUS=$(playerctl status)
        ARTIST=$(playerctl metadata artist 2>/dev/null)
        TITLE=$(playerctl metadata title 2>/dev/null)
        if [ "$STATUS" = "Playing" ]; then
            ICON=""
        elif [ "$STATUS" = "Paused" ]; then
            ICON=""
        else
            ICON=""
        fi
        echo "$ICON $ARTIST - $TITLE"
    else
        echo " No music"
    fi
}

# Weather updater in background
(while true; do
    WEATHER=$(curl -s wttr.in/chicago?format=j1 | grep -m 1 "temp_C" | grep -Eo "[0-9]+")
    echo "$WEATHER" > "$WEATHER_FILE"
    sleep 1800
done) &

# Main output loop
(while true; do
    TIME=$(date +'%a %F %H:%M:%S')
    MEM_INFO=$(free -m | awk '/Mem:/ {print $3, $2}')
    MEM_USED=$(echo $MEM_INFO | awk '{print $1}')
    MEM_TOTAL=$(echo $MEM_INFO | awk '{print $2}')
    MEM_PERCENT=$((MEM_USED * 100 / MEM_TOTAL))
    MEM_BAR=$(make_bar $MEM_PERCENT)

    CPU_PERCENT=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    CPU_USED=$(printf "%.0f" "$(echo "$CPU_PERCENT")")
    CPU_BAR=$(make_bar $CPU_USED)

    PLAYER=$(get_player_status)
    UPTIME=$(uptime | awk -F 'up ' '{print $2}' | awk -F ',' '{print $1}' | sed 's/^ *//')
    WEATHER=$(cat "$WEATHER_FILE")

    echo "[
        {\"name\": \"player\", \"full_text\": \"$PLAYER\", \"color\": \"#d08770\"},
        {\"full_text\": \" $CPU_PERCENT% $CPU_BAR\", \"color\": \"#a3be8c\"},
        {\"full_text\": \" $MEM_PERCENT% $MEM_BAR\", \"color\": \"#b48ead\"},
        {\"name\": \"weather\", \"full_text\": \"󰔏 $WEATHER°C\", \"color\": \"#f9e2af\"},
        {\"full_text\": \" $UPTIME\", \"color\": \"#a6e3a1\"},
        {\"name\": \"calendar\", \"full_text\": \"󰥔 $TIME\", \"color\": \"#88c0d0\"},
        {\"name\": \"powermenu\", \"full_text\": \"󰣇 \", \"color\": \"#89b4fa\"}
    ],"
    sleep 1
done) &

# Click event handler
while read -r line; do
    if [[ $line == *"name"*"player"* ]]; then
        playerctl play-pause
    elif [[ $line == *"name"*"weather"* ]] then
        WEATHER=$(curl -s wttr.in/chicago?format=j1 | grep -m 1 "temp_C" | grep -Eo "[0-9]+")
        echo "$WEATHER" > "$WEATHER_FILE"
        dunstify "Weather Updated" "Pinged wttr.in to get the current weather"
    elif [[ $line == *"name"*"powermenu"* ]] then
        ~/.config/sway/scripts/power-menu.sh
    elif [[ $line == *"name"*"calendar"* ]] then
        ~/.config/sway/scripts/calendar.sh
    fi
done

# TIME=$(date +'%a %F %H:%M:%S')
# MEM_USED=$(free -m | awk '/Mem:/ {printf "%d/%dMB", $3, $2}')
# CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
# PLAYER=$(get_player_status)
# UPTIME=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)
# WEATHER=$(cat "$WEATHER_FILE")

# echo "[
#     {\"name\": \"player\", \"full_text\": \"$PLAYER\", \"color\": \"#d08770\"},
#     {\"full_text\": \" CPU: $CPU\", \"color\": \"#a3be8c\"},
#     {\"full_text\": \" RAM: $MEM_USED\", \"color\": \"#b48ead\"},
#     {\"name\": \"weather\", \"full_text\": \"󰔏$WEATHER°C\", \"color\": \"#f9e2af\"},
#     {\"full_text\": \"󱫠 $UPTIME\", \"color\": \"#a6e3a1\"},
#     {\"name\": \"calendar\", \"full_text\": \"󰥔 $TIME\", \"color\": \"#88c0d0\"},
#     {\"name\": \"powermenu\", \"full_text\": \"󰣇 \", \"color\": \"#89b4fa\"}
# ],"
