#!/usr/bin/env bash
export DISPLAY=:0.0
MyBat=$(cat /sys/class/power_supply/BAT0/capacity)

if [[ $MyBat -lt 30 ]]; then
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c yellow -d 15 <<< "
    low power low power low power low power low power low power low power low power low power low power low power low power low power low power
    " >& /home/nan/.osd.log
elif [[ $MyBat -lt 15 ]]; then
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c red -d 30 <<< "
    low power low power low power low power low power low power low power low power low power low power low power low power low power low power
    " >& /home/nan/.osd.log
fi

