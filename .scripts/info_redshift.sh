#!/usr/bin/env bash
export DISPLAY=:0.0

MyFile=/home/nan/.scripts/current_redshift

# for resetting the redshift
[[ $1 -eq 0 ]] && rm $MyFile

# if no file set default value
[[ -f $MyFile ]] || echo "6500" > $MyFile

MyRedshift=$(cat $MyFile)
((MyRedshift += $1))

redshift -P -O $MyRedshift
echo $MyRedshift > $MyFile

osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c red -d 1 <<< "
$MyRedshift redshift
" >& /home/nan/osd.log

