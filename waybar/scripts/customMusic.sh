#!/bin/bash

escape_pango_json() {
  local input="$1"
  input="${input//\\/\\\\}"
  input="${input//\"/\\\"}"
  input="${input//&/&amp;}"
  input="${input//</&lt;}"
  input="${input//>/&gt;}"
  input="${input//\'/&}"
  echo "$input"
}

STATUS=$(playerctl status 2>/dev/null)
TITLE=$(playerctl metadata xesam:title 2>/dev/null)
ARTIST=$(playerctl metadata xesam:artist 2>/dev/null)

# If not playing anything
if [[ -z "$TITLE" || "$STATUS" == "Stopped" ]]; then
  echo '{ "text": " No music", "tooltip": "Nothing playing", "class": "inactive" }'
  exit 0
fi

# Set icon and class
if [[ "$STATUS" == "Playing" ]]; then
  ICON=""
  CLASS="playing"
else
  ICON=""
  CLASS="paused"
fi

# Escape text and tooltip safely
ESC_TITLE=$(escape_pango_json "$TITLE")
ESC_ARTIST=$(escape_pango_json "$ARTIST")

echo "{ \"text\": \"$ICON $ESC_TITLE\", \"tooltip\": \"$ESC_ARTIST - $ESC_TITLE\", \"class\": \"$CLASS\"}" 2>/dev/null
