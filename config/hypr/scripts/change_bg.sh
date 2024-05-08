#!/usr/bin/env bash
killall swaybg
wallpapers="/home/$USER/Pictures/wallpapers/"
img=$(fd -a "jpg|png" "$wallpapers" | shuf -n 1 --random-source=/dev/random)
notify-send "🌕 wallpapers~"
swaybg -i "$img" -m fill &
