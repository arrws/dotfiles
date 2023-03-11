#!/bin/sh
mpc play "$(mpc listall | sort | nl -nln -s' ' -ba | dmenu -nb black -nf '#DDDDDD' -sb darkblue -sf white -fn 'Source Code Pro-12.0:antialias=true' -p '>' -i -l 20 | cut -d' ' -f1)"
