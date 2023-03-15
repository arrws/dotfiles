#!/usr/bin/env bash
export DISPLAY=:0.0
for i in {0..2}
do
    osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c cyan -d 1 <<< "X" >& $HOME/.bin/.osd.log
    sleep 1
done
