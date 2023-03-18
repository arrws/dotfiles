#!/usr/bin/env bash
export DISPLAY=:0.0
Brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
MaxBrightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
PercentBrightness=$(($Brightness*100/$MaxBrightness))

osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c yellow -d 1 <<< "
$PercentBrightness% brightness
" >& $HOME/.bin/.osd.log
