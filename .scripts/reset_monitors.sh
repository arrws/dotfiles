#!/bin/sh

#xrandr --output DP-2 --auto --mode 2560x1440 --rotate right --right-of eDP-1 --output HDMI-1 --auto --mode 3840x2160 --left-of eDP-1

if xrandr | grep -q 'HDMI-1 connected'; then
	xrandr --output HDMI-1 --auto --mode 3840x2160 --above eDP-1
	xrandr --output eDP-1 --pos 960x2160
else
	xrandr --output HDMI-1 --off
fi

/run/current-system/sw/bin/feh --no-fehbg --bg-max /home/nan/.skynet.png
