#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl monitors | awk 'NR==10{print $2}')
if [ "$HYPRGAMEMODE" = 1.00 ]; then
	hyprctl keyword monitor ",prefered,0,1.50"
	notify-send -u low -t 1000 "😮 large scaling"
	exit
else
	hyprctl keyword monitor ",prefered,0,1.00"
	notify-send -u low -t 1000 "🙂 small scaling"
	exit
fi
hyprctl reload
