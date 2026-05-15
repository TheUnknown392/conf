#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 [+N% | -N%]" >&2
  exit 1
fi

ARG="$1"

# argument like +5% or -10%
if [[ ! "$ARG" =~ ^[+-][0-9]+%$ ]]; then
  echo "Error: argument must be in form +N% or -N% (example: +5% or -10%)" >&2
  exit 2
fi

# pactl
if ! command -v pactl >/dev/null 2>&1; then
  echo "Error: pactl not found." >&2
  exit 3
fi

# max %
current=$(pactl get-sink-volume @DEFAULT_SINK@ \
  | grep -o '[0-9]\+%' \
  | tr -d '%' \
  | sort -n \
  | tail -n1 || echo "0")
current=${current:-0}
current=$((current))

# deltas
delta="${ARG%\%}"   # +5 or -10
sign="${delta:0:1}"
num="${delta:1}"

# new volume
if [ "$sign" = "+" ]; then
  new=$(( current + num ))
else
  new=$(( current - num ))
fi

# Clamp
if [ "$new" -gt 100 ]; then new=100; fi
if [ "$new" -lt 0 ]; then new=0; fi

# minimum: 21..100 (so 1..20 => 21)
if [ "$new" -gt 0 ] && [ "$new" -lt 20 ]; then
  new=20
fi

# Apply volume
pactl set-sink-volume @DEFAULT_SINK@ "${new}%"

# Print new normalized value

printf "%d\n" "$new"

normalized=$(( (new - 20) * 100 / 80 ))


notify-send -r 123456 -u low "Volume: ${normalized}"


exit 0

