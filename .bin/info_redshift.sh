#!/usr/bin/env bash
export DISPLAY=:0.0

MyFile=$HOME/.bin/.current_redshift.temp

# for resetting the redshift
[[ $1 -eq 0 ]] && rm $MyFile

# if no file set default value
[[ -f $MyFile ]] || echo "6500" > $MyFile

# change redshift
MyRedshift=$(cat $MyFile)
((MyRedshift += $1))

# update file
redshift -P -O $MyRedshift
echo $MyRedshift > $MyFile

osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c red -d 1 <<< "
$MyRedshift redshift
" >& $HOME/.bin/.osd.log

