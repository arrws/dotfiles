#!/usr/bin/env bash
export DISPLAY=:0.0
MyMute=$(amixer sget Master | grep "Front Left: Playback" | cut -d' ' -f8)
MyVolume=$(amixer sget Master | grep "Front Left: Playback" | cut -d' ' -f6)
MaxVolume=$(amixer sget Master | grep "Limits" | cut -d' ' -f7)
PercentVolume=$(($MyVolume*100/$MaxVolume))

echo ${MyMute:1:-1}
if [[ ${MyMute:1:-1} == "off" ]]; then
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c green -d 1 <<< "
    $PercentVolume% volume [MUTED]
    " >& $HOME/.bin/.osd.log
else
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c green -d 1 <<< "
    $PercentVolume% volume
    " >& $HOME/.bin/.osd.log
fi
