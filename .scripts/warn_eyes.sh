#!/usr/bin/env bash
export DISPLAY=:0.0
export TEXT="
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::   E  Y  E  S   ::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
"

for i in {0..5}
do
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c cyan -d 2 <<< $TEXT >& /home/nan/osd.log
    sleep 1
done