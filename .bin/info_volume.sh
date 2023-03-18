#!/usr/bin/env bash
export DISPLAY=:0.0
Muted=$(amixer sget Master | grep "Front Left: Playback" | cut -d' ' -f8)
Volume=$(amixer sget Master | grep "Front Left: Playback" | cut -d' ' -f6)
MaxVolume=$(amixer sget Master | grep "Limits" | cut -d' ' -f7)
PercentVolume=$(($Volume*100/$MaxVolume))

echo ${Muted:1:-1}
if [[ ${Muted:1:-1} == "off" ]]; then
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c green -d 1 <<< "
    $PercentVolume% volume [MUTED]
    " >& $HOME/.bin/.osd.log
else
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c green -d 1 <<< "
    $PercentVolume% volume
    " >& $HOME/.bin/.osd.log
fi
