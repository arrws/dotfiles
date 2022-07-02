#!/usr/bin/env bash
export DISPLAY=:0.0

MyBright=$(cat /sys/class/backlight/intel_backlight/brightness)
MaxBright=$(cat /sys/class/backlight/intel_backlight/max_brightness)
PercentBright=$(($MyBright*100/$MaxBright))

osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c yellow -d 1 <<< "
$PercentBright% brightness
" >& /home/nan/.osd.log
