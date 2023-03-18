#!/usr/bin/env bash
export DISPLAY=:0.0
Filepath=$HOME/.bin/.current_redshift.temp

# for resetting the redshift
[[ $1 -eq 0 ]] && rm $Filepath

# if no file set default value
[[ -f $Filepath ]] || echo "6500" > $Filepath

# change redshift
Redshift=$(cat $Filepath)
((Redshift += $1))

# update file
redshift -P -O $Redshift
echo $Redshift > $Filepath

osd_cat -f -*-helvetica-*-r-*-*-32-*-*-*-*-*-*-* -A center -p middle -c red -d 1 <<< "
$Redshift redshift
" >& $HOME/.bin/.osd.log

