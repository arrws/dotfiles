#!/bin/sh
MONITOR=`xrandr | rg -o "^.* connected" | rg -v "eDP-1" | sd " connected" ""`

if ! test -z $MONITOR ; then
    echo "Setting monitor: $MONITOR"
	xrandr --output $MONITOR --auto --mode 3840x2160 --above eDP-1
    # xrandr --output $MONITOR --auto --mode 3840x2160 --rotate right --right-of eDP-1
	xrandr --output eDP-1 --pos 960x2160
fi

feh --no-fehbg --bg-max $HOME/.bin/.skynet.png
