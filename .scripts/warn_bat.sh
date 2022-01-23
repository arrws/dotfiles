#!/usr/bin/env bash
export DISPLAY=:0.0
MyBat=$(cat /sys/class/power_supply/BAT0/capacity)

if [[ $MyBat -lt 33 ]]; then
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c red -d 40 <<< "
    low power low power low power low power low power low power low power low power low power low power low power low power low power low power
    " >& /home/nan/.osd.log
fi

