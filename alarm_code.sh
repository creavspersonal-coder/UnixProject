#!/bin/bash
# ==============================
# Simple Alarm Clock Script
# Author: Aditya Dwivedi
# Description: Asks user for a specific time and alerts them with a message at that time
# ==============================

echo "Enter the alarm time in 24-hour format (HH:MM): "
read alarm_time

# Validate input format
if ! [[ $alarm_time =~ ^([01]?[0-9]|2[0-3]):[0-5][0-9]$ ]]; then
    echo "Invalid time format. Use HH:MM (e.g., 07:30 or 23:45)."
    exit 1
fi

# Extract hours and minutes
alarm_hour=${alarm_time%:*}
alarm_minute=${alarm_time#*:}

echo "Alarm set for $alarm_time. Waiting..."

while true; do
    current_time=$(date +"%H:%M")
    if [ "$current_time" == "$alarm_time" ]; then
        echo -e "\n⏰ Wake Up! It's $alarm_time!"
        # Beep sound if available
        if command -v play >/dev/null 2>&1; then
            play -nq -t alsa synth 0.5 sine 1000
        elif command -v paplay >/dev/null 2>&1; then
            paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
        else
            echo -e "\a" # fallback beep
        fi
        break
    fi
    sleep 30  # check every 30 seconds
done