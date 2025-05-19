#!/bin/bash

# Paths (adjust if needed)
gpu_usage_path="/sys/class/hwmon/hwmon1/device/gpu_busy_percent"
gpu_temp_path="/sys/class/hwmon/hwmon1/temp1_input"

# Read GPU usage
if [[ -f "$gpu_usage_path" ]]; then
    gpu_usage=$(cat "$gpu_usage_path")
else
    gpu_usage="N/A"
fi

# Read GPU temp (in °C)
if [[ -f "$gpu_temp_path" ]]; then
    gpu_temp=$(( $(cat "$gpu_temp_path") / 1000 ))
else
    gpu_temp="N/A"
fi

# JSON output
tooltip="GPU Temp: ${gpu_temp}°C"
tooltip="${tooltip//\"/\\\"}"  # Escape quotes

echo "{\"text\": \"󰢮 ${gpu_usage}%\", \"tooltip\": \"${tooltip}\"}"
