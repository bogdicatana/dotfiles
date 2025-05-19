#!/bin/bash

# Fetch weather data from wttr.in
weather_json=$(curl -sf "https://wttr.in/?format=j1")

# Exit if request failed
if [ $? -ne 0 ] || [ -z "$weather_json" ]; then
  echo '{"text":"","tooltip":"Weather unavailable"}'
  exit 1
fi

# Extract values using grep and extended regex
temp_c=$(echo "$weather_json" 2>/dev/null | grep -m 1 "temp_C" | grep -Eo "[0-9]+") 2>/dev/null
feels_like=$(echo "$weather_json" 2>/dev/null | grep -m 1 "FeelsLikeC" | grep -Eo "[0-9]+" ) 2>/dev/null
code=$(echo "$weather_json" 2>/dev/null | grep -m 1 "weatherCode" | grep -Eo "[0-9]+" )
desc=$(echo "$weather_json" 2>/dev/null | grep -m 1 -A 3 "weatherDesc" | grep "value" | cut -d':' -f2 | tr -d '"' | cut -b"2-" ) 2>/dev/null

# If temp_c is empty, show fallback
# Fallback if temp is empty
if [ -z "$temp_c" ]; then
  echo '{"text":"","tooltip":"Weather data unavailable"}'
  exit 1
fi

# Map weather code to icon
# Reference: https://developer.worldweatheronline.com/api/docs/weather-icons.aspx
case "$code" in
  113) icon="" ;;    # Clear/Sunny
  116) icon="" ;;    # Partly Cloudy
  119|122) icon="☁️" ;;  # Cloudy
  143|248|260) icon="" ;; # Mist/Fog
  176|263|266|281|293|296|299|302|305|308|311|314|317|320) icon="" ;; # Light rain variants
  179|182|185|227|230|323|326|329|332|335|338|350|365|368|371|374|377) icon="" ;; # Snow variants
  200|386|389|392|395) icon="" ;; # Thunderstorm variants
  353|356|359|362) icon="" ;; # Heavy rain
  *) icon="❓" ;; # Unknown
esac

# Output Waybar JSON
echo "{\"text\":\"$icon ${temp_c}°C\",\"tooltip\":\"$desc\nFeels like ${feels_like}°C\"}"
