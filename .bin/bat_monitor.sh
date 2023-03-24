#!/bin/sh
(cat /sys/class/power_supply/BAT0/capacity | tr '\n' ,; date +%s) >> $HOME/.battery.csv
