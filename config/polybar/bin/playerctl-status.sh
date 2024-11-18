#!/bin/sh

player_status="$(playerctl status 2> /dev/null)"

if [[ "$player_status" = "Playing" || "$player_status" = "Paused" ]]; then
    exit 0
else
    exit 1
fi
