mpc play "$(mpc ls | sort | nl -nln -s' ' -ba | dmenu -nb black -nf '#DDDDDD' -sb darkblue -sf white -fn 'Source Code Pro-12.0:antialias=true' -p '>' -i -l 43 | cut -d' ' -f1)"
