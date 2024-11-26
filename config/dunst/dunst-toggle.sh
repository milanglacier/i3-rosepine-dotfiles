#!/usr/bin/env bash

if [ "$(dunstctl is-paused)" = "true" ]; then
    dunstify -u low "dunst activated"
else
    dunstify -u low "dunst paused"
fi

sleep 1

dunstctl set-paused toggle
