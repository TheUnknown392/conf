#!/bin/bash

# Prevent multiple instances
PIDFILE="/tmp/battery-monitor.pid"
if [ -e "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")"; then
    echo "Already running"
    exit 1
fi
echo $$ > "$PIDFILE"

# Notification flags
warn15_sent=false
warn12_sent=false
shutdown_sent=false

while true; do
    # Get battery percentage
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    battery_status=$(acpi -b | awk '{print $3}' | tr -d ',')

    # discharging
    if [[ "$battery_status" == "Discharging" ]]; then
        if [[ $battery_level -le 15 && $warn15_sent == false ]]; then
            notify-send "⚠️ Battery Low" "Battery at $battery_level%. Plug in soon."
            warn15_sent=true
        fi

        if [[ $battery_level -le 12 && $warn12_sent == false ]]; then
            notify-send "❗ Battery Critical" "Battery at $battery_level%. Plug in immediately!"
            warn12_sent=true
        fi

        if [[ $battery_level -le 10 && $shutdown_sent == false ]]; then
            notify-send "🔋 Shutting Down" "Battery critically low ($battery_level%)."
            shutdown_sent=true
            sleep 10
            systemctl poweroff
        fi
    else
        # charging
        warn15_sent=false
        warn12_sent=false
        shutdown_sent=false
    fi

    sleep 60
done
