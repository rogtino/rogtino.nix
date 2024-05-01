#!/usr/bin/env bash
wallpapers="/home/$USER/Pictures/wallpapers/"
while true; do
	killall swaybg
	img=$(fd -a "jpg|png" "$wallpapers" | shuf -n 1 --random-source=/dev/random)
	swaybg -i "$img" -m fill &
	sleep 5m
done
