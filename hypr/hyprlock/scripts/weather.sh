#!/usr/bin/env bash

# HARDCODE Location & City
CITY=$(grep -oP '^\s*\$CITY\s*=\s*\K.+' ~/.config/hypr/hyprlock/hyprlock.conf | xargs)
COUNTRY=$(grep -oP '^\s*\$COUNTRY\s*=\s*\K.+' ~/.config/hypr/hyprlock/hyprlock.conf | xargs)

# Check if CITY and COUNTRY are valid
if [[ -z "$CITY" || -z "$COUNTRY" ]]; then
  echo "Error: Unable to determine your location from hyprlock.conf"
  exit 1
fi

# Fetch weather info for the detected city from wttr.in
cache_file="/tmp/weather_cache"
if [[ -f $cache_file && $(find "$cache_file" -mmin -15 | wc -l) -gt 0 ]]; then
  weather_info=$(cat "$cache_file")
else
  weather_info=$(curl -s "https://wttr.in/$CITY?format=1" 2>/dev/null)
  echo "$weather_info" > "$cache_file"
fi


# Check if curl succeeded
if [[ $? -ne 0 || -z "$weather_info" ]]; then
  echo "Error: Failed to retrieve weather info for $COUNTRY, $CITY"
  exit 1
fi

echo "$weather_info"

