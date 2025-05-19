#!/bin/bash

while true; do
    BAR_ID="bar-0"

    WORKSPACE_OUT=$(swaymsg -t get_workspaces)
    BAR_CONFIG=$(swaymsg -t get_bar_config "$BAR_ID")

    # Count empty and non-visible workspaces
    EMPTY_WORKSPACES=$(($(echo "$WORKSPACE_OUT" | grep "\"representation\": null" | wc -l) + $(echo "$WORKSPACE_OUT" | grep "\"representation\": \"H\\[\\]\"" | wc -l)))
    WORKSPACE_COUNT=$(($(echo "$WORKSPACE_OUT" | grep "\"num\":" | wc -l) - $(echo "$WORKSPACE_OUT" | grep "\"visible\": false" | wc -l)))

    # Get current bar mode
    CURRENT_MODE=$(echo "$BAR_CONFIG" | grep '"mode":' | awk -F '"' '{print $4}')

	if [ "$(pgrep -x rofi)" != "" ]; then
        # Rofi is visible; keep bar docked
        if [ "$CURRENT_MODE" != "dock" ]; then
            swaymsg bar "$BAR_ID" mode dock
        fi
    else
        # Rofi not visible; toggle bar based on workspace count
        if [ "$WORKSPACE_COUNT" -gt "$EMPTY_WORKSPACES" ] && [ "$CURRENT_MODE" != "dock" ]; then
            swaymsg bar "$BAR_ID" mode dock
        elif [ "$WORKSPACE_COUNT" -eq "$EMPTY_WORKSPACES" ] && [ "$CURRENT_MODE" != "hide" ]; then
            swaymsg bar "$BAR_ID" mode hide
        fi
    fi
	sleep 0.3
done
