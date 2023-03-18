#!/usr/bin/env bash
export DISPLAY=:0.0
Capacity=$(cat /sys/class/power_supply/BAT0/capacity)
Status=$(cat /sys/class/power_supply/BAT0/status)

if [[ $Capacity -lt 15 && $Status != "Charging" ]]; then
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c red -d 30 <<< "
    low power low power low power low power low power low power low power low power low power low power low power low power low power low power
    " >& $HOME/.bin/.osd.log
elif [[ $Capacity -lt 30 && $Status != "Charging" ]]; then
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c yellow -d 15 <<< "
    low power low power low power low power low power low power low power low power low power low power low power low power low power low power
    " >& $HOME/.bin/.osd.log
fi

